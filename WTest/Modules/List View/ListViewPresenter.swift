//
//  ListViewPresenter.swift
//  WTest
//
//  Created by Edson iMAC on 16/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import UIKit

class ListViewPresenter: ListViewViewToPresenterProtocol {
    var view: ListViewPresenterToViewProtocol?
    var interactor: ListViewPresenterToInteractorProtocol?
    var router: ListViewPresenterToRouterProtocol?
}

extension ListViewPresenter: ListViewInteractorToPresenterProtocol {
    func viewDidLoad() {}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Config.tableViewCounter
    }
}
