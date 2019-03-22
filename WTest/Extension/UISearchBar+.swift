//
//  UISearchBar+.swift
//  WTest
//
//  Created by Edson iMAC on 21/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import UIKit

extension UISearchBar {
    
    func getSearchBarTextField() -> UITextField? {
        let textFieldInsideSearchBar = self.value(forKey: "searchField") as? UITextField
        return textFieldInsideSearchBar
    }
    
    func setTextColor(color: UIColor) {
        if let textField = getSearchBarTextField() {
            textField.textColor = color
        }
    }
    
    func setTextFieldColor(color: UIColor) {
        if let textField = getSearchBarTextField() {
            switch searchBarStyle {
            case .minimal:
                textField.layer.backgroundColor = color.cgColor
                textField.layer.cornerRadius = 6
                
            case .prominent, .default:
                textField.backgroundColor = color
            }
        }
    }
    
    func setPlaceholderTextColor(color: UIColor) {
        if let textField = getSearchBarTextField() {
            textField.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: color])
        }
    }
    
    func setTextFieldClearButtonColor(color: UIColor) {
        if let textField = getSearchBarTextField() {
            if let clearButton = textField.value(forKey: "clearButton") as? UIButton {
                clearButton.setImage(UIImage(named: "ic_clear"), for: .normal)
                clearButton.setImage(UIImage(named: "ic_clear"), for: .highlighted)
                clearButton.tintColor = .white
            }
        }
    }
    
    func setSearchImageColor(color: UIColor) {
        if let imageView = getSearchBarTextField()?.leftView as? UIImageView {
            imageView.image = imageView.image?.transform(withNewColor: color)
        }
    }
}
