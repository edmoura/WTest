//
//  PostalCodeProtocols.swift
//  WTest
//
//  Created by Edson iMAC on 16/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import Foundation
import UIKit

protocol PostalCodePresenterToViewProtocol: class {
    //Presenter -> View
}

protocol PostalCodeViewToPresenterProtocol: class {
    //View -> Presenter
    var view: PostalCodePresenterToViewProtocol? {get set}
    var interactor: PostalCodePresenterToInteractorProtocol? {get set}
    var router: PostalCodePresenterToRouterProtocol? {get set}
    func viewDidLoad()
    //func showFruitSelection(with fruit: Fruit, from view: UIViewController)
}

protocol PostalCodePresenterToInteractorProtocol: class {
    //Presenter -> Interactor
    var presenter: PostalCodeInteractorToPresenterProtocol? {get set}
}

protocol PostalCodeInteractorToPresenterProtocol: class {
    //Interactor -> Presenter
}

protocol PostalCodePresenterToRouterProtocol: class {
    //Presenter -> Router
    static func createModule(viewRef: PostalCodeViewController)
}
