//
//  PostalCodeProtocols.swift
//  WTest
//
//  Created by Edson iMAC on 16/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import Foundation
import UIKit

protocol PostalCodePresenterToRouterProtocol: class {
    //Router
    static func createModule(viewRef: PostalCodeViewController)
}

protocol PostalCodePresenterToViewProtocol: class {
    //View
    func showCustomAlert(alert: UIAlertController, callback: @escaping () -> Void)
    func hideLoading()
    func showLoading()
    func startTableView(models: [ConcelhoModel])
    func reloadTableData()
    func setViewEditing()
    func setSearchBarPlaceHolder(name: String)
}

protocol PostalCodeViewToPresenterProtocol: class {
    //Presenter
    var view: PostalCodePresenterToViewProtocol? {get set}
    var interactor: PostalCodePresenterToInteractorProtocol? {get set}
    var router: PostalCodePresenterToRouterProtocol? {get set}
    func viewDidLoad()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar)
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
}

protocol PostalCodePresenterToInteractorProtocol: class {
    //Interactor
    var presenter: PostalCodeInteractorToPresenterProtocol? {get set}
    func getPostalCode(callback: @escaping(Result<[ConcelhoModel]>) -> Void)
}

protocol PostalCodeInteractorToPresenterProtocol: class {
    //Interactor -> Presenter
}

