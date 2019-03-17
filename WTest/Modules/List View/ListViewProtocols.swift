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
}

protocol ListViewViewToPresenterProtocol: class {
    //View -> Presenter
    var view: ListViewPresenterToViewProtocol? {get set}
    var interactor: ListViewPresenterToInteractorProtocol? {get set}
    var router: ListViewPresenterToRouterProtocol? {get set}
    func viewDidLoad()
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
