//
//  ListViewProtocols.swift
//  WTest
//
//  Created by Edson iMAC on 16/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import Foundation
import UIKit

protocol ListViewPresenterToViewProtocol: class {
    //Presenter -> View
    func setTitleView(title: String)
}

protocol ListViewViewToPresenterProtocol: class {
    //View -> Presenter
    var view: ListViewPresenterToViewProtocol? {get set}
    var interactor: ListViewPresenterToInteractorProtocol? {get set}
    var router: ListViewPresenterToRouterProtocol? {get set}
    func viewDidLoad()
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
}

protocol ListViewPresenterToInteractorProtocol: class {
    //Presenter -> Interactor
    var presenter: ListViewInteractorToPresenterProtocol? {get set}
}

protocol ListViewInteractorToPresenterProtocol: class {
    //Interactor -> Presenter
}

protocol ListViewPresenterToRouterProtocol: class {
    //Presenter -> Router
    static func createModule(viewRef: ListViewController)
}
