//
//  FieldTableViewCell.swift
//  WTest
//
//  Created by Edson iMAC on 17/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import UIKit

protocol FieldTableViewCellDelegate: class {
    func dismissKeyboard()
    func hidePickerComponent()
    func showDates(row: IndexPath)
    func showList(row: IndexPath)
}

protocol FieldTableProtocol {
    func setType(type: FieldModule, row: IndexPath)
    func setDate(components: DateComponents)
    func setCountry(country: String)
}

class FieldTableViewCell: UITableViewCell, FieldTableProtocol {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var labelType: UILabel!
    
    weak var delegate: FieldTableViewCellDelegate?
    private var type: FieldModule?
    private var row: IndexPath?
    private var titles: [String] = ["texto normal", "números", "forçar maiúsculas", "datas", "seleccionar entrada duma lista"]

    override func awakeFromNib() {
        super.awakeFromNib()
        field.delegate = self
    }
    
    override func prepareForReuse() {
        self.type = .Normal
        field.textContentType = UITextContentType.familyName
        field.inputAccessoryView = UIView()
        field.text = ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setType(type: FieldModule, row: IndexPath) {
        self.type = type
        self.row = row
        labelType.text = titles[row.row % titles.count]
        switch self.type {
        case .Normal?: break
        case .Number?:
            let _inputAccessoryView = InputButtonAccessoryView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            _inputAccessoryView.delegate = self
            field.textContentType = UITextContentType.creditCardNumber
            field.inputAccessoryView = _inputAccessoryView
        case .Uppercase?: break
        case .Date?: break
        case .List?: break
        default: break
        }
    }
    
    func setDate(components: DateComponents) {
        if let day = components.day, let month = components.month, let year = components.year {
            let _day = day <= 9 ? "0\(day)" : "\(day)"
            let _month = month <= 9 ? "0\(month)" :  "\(month)"
            let _title = "\(_day)/\(_month)/\(year)"
            field.text = _title
        }
    }
    
    func setCountry(country: String) {
        field.text = country
    }
}

extension FieldTableViewCell: UITextFieldDelegate, InputButtonAccessoryProtocol {
    func buttonOkTapped(withTag tag: Int) {
        delegate?.dismissKeyboard()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.dismissKeyboard()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch self.type {
        case .Normal?: break
        case .Number?: return textFieldNumber(textField, shouldChangeCharactersIn: range, replacementString: string)
        case .Uppercase?: return textFieldUppercase(textField, shouldChangeCharactersIn: range, replacementString: string)
        case .Date?: break
        case .List?: break
        default: break
        }
        return true
    }
    
    func textFieldUppercase(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let lowercaseCharacters = NSCharacterSet.lowercaseLetters
        if string.rangeOfCharacter(from: lowercaseCharacters) != nil {
            let uppercaseString = string.uppercased
            if textField.text?.isEmpty == true {
                textField.text = (textField.text as NSString?)?.replacingCharacters(in: range, with: uppercaseString())
            } else {
                let beginning = textField.beginningOfDocument
                let start = textField.position(from: beginning, offset: range.location)
                let end = textField.position(from: start!, offset: range.length)
                let range = textField.textRange(from: start!, to: end!)
                textField.replace(range!, withText: uppercaseString())
            }
            return false
        } else {
            return true
        }
    }
    
    func textFieldNumber(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters) == nil
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if self.type == .Date {
            delegate?.showDates(row: self.row ?? IndexPath())
            return false
        } else if self.type == .List {
            delegate?.showList(row: self.row ?? IndexPath())
            return false
        } else {
            delegate?.hidePickerComponent()
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
