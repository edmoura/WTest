//
//  ListViewController.swift
//  WTest
//
//  Created by Edson iMAC on 16/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    var presenter: ListViewViewToPresenterProtocol?
    
    @IBOutlet weak var containerScrollView: UIScrollView!
    @IBOutlet weak var rootContainerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageControllerContainerView: UIView!
    @IBOutlet weak var pageControllerContainerTopAnchor: NSLayoutConstraint!
    
    var pageContainerInitialHeight = CGFloat()
    let offset: CGFloat = 44 // frame nav bar
    
    @IBOutlet weak var rootContainerHeightAnchor: NSLayoutConstraint!
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ListViewRouter.createModule(viewRef: self)
        setTitleView(title: "Cat Lover")
        configViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(color: UIColor.init(red: 61 / 255, green: 14 / 255, blue: 42 / 255, alpha: 1)), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func configViews() {
        containerScrollView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: .zero)
        tableView.contentInset = UIEdgeInsets(top: pageControllerContainerView.frame.height, left: 0, bottom: 0, right: 0)
        pageContainerInitialHeight = pageControllerContainerView.frame.height
        tableView.layoutIfNeeded()
        rootContainerHeightAnchor.constant = tableView.contentSize.height - pageContainerInitialHeight
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.init(red: 61 / 255, green: 14 / 255, blue: 42 / 255, alpha: 1)
    }
}

extension ListViewController: ListViewPresenterToViewProtocol, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func setTitleView(title: String) {
        self.navigationController?.navigationBar.topItem?.title = title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter?.tableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.tableView(tableView, numberOfRowsInSection: section) ?? 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y - tableView.contentOffset.y
        if y > 0 {
            var percent = (scrollView.contentOffset.y / (tableView.contentSize.height - self.view.frame.height - pageContainerInitialHeight))
            let brightness = 1 - max(min(1, percent), 0.0)
            percent = 1 - max(min(0.5, percent), 0.0)
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(hue: 0, saturation: 0, brightness: CGFloat(brightness), alpha: 1),
                                                                            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold)]
            self.navigationController?.navigationBar.setBackgroundImage(UIImage.imageWithColor(color: UIColor.init(red: 61 / 255, green: 14 / 255, blue: 42 / 255, alpha: percent)), for: .default)
            pageControllerContainerTopAnchor.constant = y - (pageContainerInitialHeight - offset)
            if pageControllerContainerTopAnchor.constant > 0 || pageControllerContainerTopAnchor.constant == -pageContainerInitialHeight{
                pageControllerContainerTopAnchor.constant = 0
            }
        }
    }
}
