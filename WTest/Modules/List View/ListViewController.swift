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
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        configViews()
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
    }
}

extension ListViewController: ListViewPresenterToViewProtocol, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Config.tableViewCounter
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y - tableView.contentOffset.y
        if y > 0 {
            pageControllerContainerTopAnchor.constant = y - (pageContainerInitialHeight - offset)
            if pageControllerContainerTopAnchor.constant > 0 || pageControllerContainerTopAnchor.constant == -pageContainerInitialHeight{
                pageControllerContainerTopAnchor.constant = 0
            }
        }

    }
}
