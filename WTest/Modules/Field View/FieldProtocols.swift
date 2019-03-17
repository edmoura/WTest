//
//  FieldProtocols.swift
//  WTest
//
//  Created by Edson iMAC on 17/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import Foundation

protocol FieldPresenterToViewProtocol: class {
    //Presenter -> View
}

protocol FieldViewToPresenterProtocol: class {
    //View -> Presenter
    var view: FieldPresenterToViewProtocol? {get set}
    var interactor: FieldPresenterToInteractorProtocol? {get set}
    var router: FieldPresenterToRouterProtocol? {get set}
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
