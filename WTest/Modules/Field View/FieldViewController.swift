//
//  FieldViewController.swift
//  WTest
//
//  Created by Edson iMAC on 17/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import UIKit

class FieldViewController: UIViewController {
    var presenter: FieldViewToPresenterProtocol?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FieldRouter.createModule(viewRef: self)
        presenter?.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension FieldViewController: FieldPresenterToViewProtocol {
    
}

