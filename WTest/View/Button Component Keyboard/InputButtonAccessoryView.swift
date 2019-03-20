//
//  InputButtonAccessoryView.swift
//  WTest
//
//  Created by Edson iMAC on 18/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import UIKit

class InputButtonAccessoryView: UIView {
    public weak var delegate: InputButtonAccessoryProtocol?
    public var fieldTag: Int?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        let view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
    }
    
    @IBAction func buttonOK(_ sender: Any) {
        delegate?.buttonOkTapped(withTag: fieldTag ?? 0)
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
}
