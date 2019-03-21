//
//  FieldViewController.swift
//  WTest
//
//  Created by Edson iMAC on 17/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import UIKit

class FieldViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerContent: UIView!
    
    let pickerHeight = 250
    let padding = 50
    var presenter: FieldViewToPresenterProtocol?
    var picker: PickerComponent?
    var oldContentOffset: CGPoint?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FieldRouter.createModule(viewRef: self)
        addObserver()
        configTableView()
        addTapToDismissKeyboard()
        addPickerComponent()
        setTitleView(title: "List")
    }
    
    func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.isAccessibilityElement = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.accessibilityIdentifier = "table--listTableView"
        tableView.keyboardDismissMode = .onDrag
    }
}

extension FieldViewController: FieldPresenterToViewProtocol, UITableViewDelegate, UITableViewDataSource, PickerProtocolModuleApi {
    func setTitleView(title: String) {
        self.navigationController?.navigationBar.topItem?.title = title
    }
    
    func addPickerComponent() {
        picker = PickerComponent(frame: CGRect(x: 0, y: 0, width: Int(self.view.frame.width), height: pickerHeight))
        picker?.delegate = self
        pickerContent.addSubview(picker!)
        picker?.transform = CGAffineTransform(translationX: 0, y: CGFloat(pickerHeight + padding))
        pickerContent.isUserInteractionEnabled = false
    }
    
    func hidePickerComponent() {
        if picker?.isOpen == true {
            picker?.isOpen = false
            pickerContent.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity:0.5, options: .curveEaseInOut, animations: {
                self.picker?.transform = CGAffineTransform(translationX: 0, y: CGFloat(self.pickerHeight + self.padding))
            }, completion: {(success) in
                self.picker?.reload()
            })
        }
    }
    
    func showPickerComponent(isList: Bool) {
        isList == true ? picker?.setPickerView() : picker?.setDatePicker()
        view.endEditing(true)
        if picker?.isOpen == false {
            picker?.isOpen = true
            pickerContent.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity:0.8, options: .curveEaseInOut, animations: {
                self.picker?.transform = CGAffineTransform.identity
            }, completion: {(success) in})
        }
    }
    
    func setDate(components: DateComponents) {
        presenter?.setDate(components: components)
    }
    
    func setCountry(country: String) {
        presenter?.setCountry(country: country)
    }
    
    func addTapToDismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(_dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func _dismissKeyboard() {
        view.endEditing(true)
        hidePickerComponent()
    }
    
    func dismissKeyboard() {
        _dismissKeyboard()
    }
    
    @objc func keyboard(notification: Notification) {
        if notification.userInfo != nil {
            let userInfo = notification.userInfo!
            let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let keyboardViewEndFrame = self.view.superview?.convert(keyboardScreenEndFrame, from: self.view.superview?.window)
            if notification.name == UIResponder.keyboardWillHideNotification {
                self.tableView.contentInset = .zero
            } else {
                self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: (keyboardViewEndFrame?.height ?? 250), right: 0)
            }
        }
        self.tableView.scrollIndicatorInsets = self.tableView.contentInset
    }
    
    func reloadTableData() {
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter?.tableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
}
