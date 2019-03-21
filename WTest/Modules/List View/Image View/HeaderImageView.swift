//
//  HeaderImageView.swift
//  WTest
//
//  Created by Edson iMAC on 20/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import UIKit
import Kingfisher

class HeaderImageView: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://placekitten.com/g/750/500")
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
