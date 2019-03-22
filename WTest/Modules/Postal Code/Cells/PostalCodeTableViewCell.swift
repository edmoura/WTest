//
//  PostalCodeTableViewCell.swift
//  WTest
//
//  Created by Edson iMAC on 22/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import UIKit

protocol PostalCodeProtocol {
    func setLabelTitle(model: ConcelhoModel?)
}

class PostalCodeTableViewCell: UITableViewCell, PostalCodeProtocol {
    
    @IBOutlet weak var labelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setLabelTitle(model: ConcelhoModel?) {
        if model != nil {
            let strModel: String = "Distrito: \(model?.cod_distrito ?? "")\nConcelho: \(model?.cod_concelho ?? "")\nNome: \(model?.nome_concelho ?? "")"
            labelName.text = strModel
        }
    }
}
