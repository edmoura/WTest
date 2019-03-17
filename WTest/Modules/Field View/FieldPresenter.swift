//
//  FieldPresenter.swift
//  WTest
//
//  Created by Edson iMAC on 17/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import Foundation
import UIKit

class FieldPresenter: FieldViewToPresenterProtocol {
    var view: FieldPresenterToViewProtocol?
    var interactor: FieldPresenterToInteractorProtocol?
    var router: FieldPresenterToRouterProtocol?
}

extension FieldPresenter: FieldInteractorToPresenterProtocol {
    func viewDidLoad() { }
    
    func numberOfRowsInSection() -> Int {
        return 51
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FieldTableViewCell else {
            return UITableViewCell()
        }
        cell.labelTitle.text = "field \(indexPath.row)"
        cell.isAccessibilityElement = true
        cell.accessibilityIdentifier = "cell--dataTableViewCell--\(indexPath.row)"
        return cell
    }
}
