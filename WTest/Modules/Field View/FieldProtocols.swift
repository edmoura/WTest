//
//  FieldProtocols.swift
//  WTest
//
//  Created by Edson iMAC on 17/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import Foundation
import UIKit

protocol FieldPresenterToViewProtocol: PickerProtocolModuleApi, PickerDelegateProtocol {
    //Presenter -> View
    func reloadTableData()
    func dismissKeyboard()
}

protocol FieldViewToPresenterProtocol: PickerDelegateProtocol {
    //View -> Presenter
    var view: FieldPresenterToViewProtocol? {get set}
    var interactor: FieldPresenterToInteractorProtocol? {get set}
    var router: FieldPresenterToRouterProtocol? {get set}
    func numberOfRowsInSection() -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func viewDidLoad()
}

protocol FieldPresenterToInteractorProtocol: class {
    //Presenter -> Interactor
    var presenter: FieldInteractorToPresenterProtocol? {get set}
}

protocol FieldInteractorToPresenterProtocol: class {
    //Interactor -> Presenter
}

protocol FieldPresenterToRouterProtocol: class {
    //Presenter -> Router
    static func createModule(viewRef: FieldViewController)
}
