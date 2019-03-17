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
        configTableView()
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
    }
}

extension FieldViewController: FieldPresenterToViewProtocol, UITableViewDelegate, UITableViewDataSource {
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

