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
    var currentRow: IndexPath?
    var tableView: UITableView?
}

extension FieldPresenter: FieldInteractorToPresenterProtocol, FieldTableViewCellDelegate, PickerDelegateProtocol {
    
    func hidePickerComponent() {
        view?.hidePickerComponent()
    }
    
    func viewDidLoad() { }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FieldTableViewCell else {
            return UITableViewCell()
        }
        self.tableView = tableView
        cell.labelTitle.text = "field \(indexPath.row)"
        cell.isAccessibilityElement = true
        cell.accessibilityIdentifier = "cell--dataTableViewCell--\(indexPath.row)"
        cell.delegate = self
        cell.setType(type: FieldModule.allValues[indexPath.row % FieldModule.allValues.count], row: indexPath)
        return cell
    }
    
    func numberOfRowsInSection() -> Int {
        return Config.tableViewCounter
    }
    
    func setDate(components: DateComponents) {
        if let cell = self.tableView?.cellForRow(at: currentRow ?? IndexPath()) as? FieldTableViewCell {
            cell.setDate(components: components)
        }
    }
    
    func setCountry(country: String) {
        if let cell = self.tableView?.cellForRow(at: currentRow ?? IndexPath()) as? FieldTableViewCell {
            cell.setCountry(country: country)
        }
    }
    
    func showDates(row: IndexPath) {
        currentRow = row
        view?.showPickerComponent(isList: false)
        if let _table = self.tableView {
            _table.scrollToRow(at: row, at: .top, animated: true)
        }
    }
    
    func showList(row: IndexPath) {
        currentRow = row
        view?.showPickerComponent(isList: true)
        if let _table = self.tableView {
            _table.scrollToRow(at: row, at: .top, animated: true)
        }
    }
    
    func dismissKeyboard() {
        view?.dismissKeyboard()
    }
}
