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
    
    var presenter: FieldViewToPresenterProtocol?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FieldRouter.createModule(viewRef: self)
        addObserver()
        configTableView()
        addTapToDismissKeyboard()
    }
    
    func configTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 90
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.isAccessibilityElement = true
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.accessibilityIdentifier = "table--listTableView"
        self.tableView.keyboardDismissMode = .onDrag
    }
}

extension FieldViewController: FieldPresenterToViewProtocol, UITableViewDelegate, UITableViewDataSource {
    func addTapToDismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
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
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
        return presenter?.numberOfRowsInSection() ?? 51
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter?.tableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
}

