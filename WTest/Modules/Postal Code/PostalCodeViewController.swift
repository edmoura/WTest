//
//  PostalCodeViewController.swift
//  WTest
//
//  Created by Edson iMAC on 16/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import UIKit

class PostalCodeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var presenter: PostalCodeViewToPresenterProtocol?
    var models: [ConcelhoModel]?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        PostalCodeRouter.createModule(viewRef: self)
        configTableView()
        setTitleView(title: "Search")
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = UIColor.init(red: 79 / 255, green: 22 / 255, blue: 56 / 255, alpha: 1)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.init(red: 79 / 255, green: 22 / 255, blue: 56 / 255, alpha: 1)
    }
    
    func configTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.searchBar.delegate = self
        self.searchBar.searchBarStyle = .minimal
        self.searchBar.placeholder = "Search"
        self.searchBar.isAccessibilityElement = true
        self.searchBar.accessibilityIdentifier = "SearchBar"
        self.searchBar.setTextColor(color: .white)
        self.searchBar.setPlaceholderTextColor(color: .white)
        self.searchBar.setSearchImageColor(color: .white)
        self.searchBar.setTextFieldClearButtonColor(color: .white)
    }
}

extension PostalCodeViewController: PostalCodePresenterToViewProtocol, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func setViewEditing() {
        view.endEditing(true)
    }
    
    func setSearchBarPlaceHolder(name: String) {
        self.searchBar.placeholder = name
        self.searchBar.setPlaceholderTextColor(color: .white)
    }
    
    func startTableView(models: [ConcelhoModel]) {
        self.models = models
    }
    
    func reloadTableData() {
        self.tableView.reloadData()
    }
    
    func hideLoading() {
        self.loading.stopAnimating()
    }
    
    func showLoading() {
        self.loading.startAnimating()
    }
    
    func showCustomAlert(alert: UIAlertController, callback: @escaping () -> Void) {
        self.present(alert, animated: true) {
            callback()
        }
    }
    
    func setTitleView(title: String) {
        self.navigationController?.navigationBar.topItem?.title = title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.tableView(tableView, numberOfRowsInSection: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return presenter?.tableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return presenter?.tableView(tableView, didSelectRowAt: indexPath) ?? ()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        return presenter?.tableView(tableView, didDeselectRowAt: indexPath) ?? ()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        return presenter?.searchBarTextDidBeginEditing(searchBar) ?? ()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        return presenter?.searchBarTextDidEndEditing(searchBar) ?? ()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        return presenter?.searchBarCancelButtonClicked(searchBar) ?? ()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        return presenter?.searchBarSearchButtonClicked(searchBar) ?? ()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return presenter?.searchBarShouldBeginEditing(searchBar) ?? true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        return presenter?.searchBar(searchBar, textDidChange: searchText) ?? ()
    }
}
