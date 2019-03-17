//
//  PostalCodeViewController.swift
//  WTest
//
//  Created by Edson iMAC on 16/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import UIKit

class PostalCodeViewController: UIViewController {
    var presenter: PostalCodeViewToPresenterProtocol?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        PostalCodeRouter.createModule(viewRef: self)
        presenter?.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
}

extension PostalCodeViewController: PostalCodePresenterToViewProtocol {
    
}
