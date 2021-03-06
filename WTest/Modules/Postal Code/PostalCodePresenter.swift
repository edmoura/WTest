//
//  PostalCodePresenter.swift
//  WTest
//
//  Created by Edson iMAC on 16/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import UIKit

class PostalCodePresenter: PostalCodeViewToPresenterProtocol {
    var view: PostalCodePresenterToViewProtocol?
    var interactor: PostalCodePresenterToInteractorProtocol?
    var router: PostalCodePresenterToRouterProtocol?
    let base: BaseInteractor = BaseInteractor()
    var _concelho: [ConcelhoModel]?
    var searchArray: [ConcelhoModel]? = []
    var isSearching: Bool = false
}

extension PostalCodePresenter: PostalCodeInteractorToPresenterProtocol {
    func viewDidLoad() {
        if let _concelho: [ConcelhoModel] = base.getDataFromDisk(path: "concelho.json") {
            self._concelho = _concelho
            self.view?.hideLoading()
            self.view?.startTableView(models: _concelho)
            self.view?.reloadTableData()
        } else {
            interactor?.getPostalCode(callback: { (concelhoResult) in
                switch concelhoResult {
                case .success(let concelho):
                    self._concelho = concelho
                    self.base.saveDataInDisk(data: concelho, name: "concelho.json")
                    self.view?.hideLoading()
                    self.view?.startTableView(models: concelho)
                    self.view?.reloadTableData()
                case .failure(let error):
                    let alertController = UIAlertController(title: "WTest", message: error.localizedDescription, preferredStyle: .alert)
                    let cancel = UIAlertAction(title: "Cancelar", style: .default) { (action:UIAlertAction) in}
                    alertController.addAction(cancel)
                    self.view?.showCustomAlert(alert: alertController, callback: {})
                }
            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching == false ? self._concelho?.count ?? 0 : self.searchArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PostalCodeTableViewCell else {
            return UITableViewCell()
        }
        var tempCell: [ConcelhoModel]?
        isSearching == false ? (tempCell = self._concelho) : (tempCell = self.searchArray)
        if let _model: ConcelhoModel = tempCell?[exist: indexPath.row] {
            cell.setLabelTitle(model: _model)
        } else {
            cell.setLabelTitle(model: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view?.setViewEditing()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) { }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {}
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {}
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {}
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text == nil || searchBar.text == "" {
            view?.setSearchBarPlaceHolder(name: "Search")
            self.searchArray = []
            view?.reloadTableData()
            isSearching = false
        }
        view?.setViewEditing()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        view?.setSearchBarPlaceHolder(name: "")
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = false
            self.searchArray = []
            view?.reloadTableData()
        }
        if searchBar.text?.count ?? 0 > 1 {
            isSearching = true
            self.searchArray = self._concelho?.filter { return $0.cod_distrito?.contains(searchText) ?? false || $0.cod_distrito?.contains(searchText) ?? false || $0.nome_concelho?.contains(searchText) ?? false || $0.nome_concelho?.lowercased().contains(searchText) ?? false }
            view?.reloadTableData()
        }
    }
}
