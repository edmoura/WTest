//
//  ListViewPresenter.swift
//  WTest
//
//  Created by Edson iMAC on 16/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import Foundation

class ListViewPresenter: ListViewViewToPresenterProtocol {
    var view: ListViewPresenterToViewProtocol?
    var interactor: ListViewPresenterToInteractorProtocol?
    var router: ListViewPresenterToRouterProtocol?
}

extension ListViewPresenter: ListViewInteractorToPresenterProtocol {
    func viewDidLoad() {
        print("ListViewPresenter viewDidLoad")
    }
}
