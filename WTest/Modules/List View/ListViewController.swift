//
//  ListViewController.swift
//  WTest
//
//  Created by Edson iMAC on 16/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import UIKit


class ListViewController: UIViewController {
    var presenter: ListViewViewToPresenterProtocol?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        ListViewRouter.createModule(viewRef: self)
        presenter?.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
}

extension ListViewController: ListViewPresenterToViewProtocol {
    
}
