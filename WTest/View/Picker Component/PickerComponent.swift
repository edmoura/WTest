//
//  PickerComponent.swift
//  WTest
//
//  Created by Edson iMAC on 18/03/2019.
//  Copyright © 2019 Edson Moura. All rights reserved.
//

import UIKit

protocol PickerDelegateProtocol: class {
    func setDate(components: DateComponents)
    func setCountry(country: String)
    func hidePickerComponent()
}

protocol PickerComponentProtocol {
    func setPickerView()
    func setDatePicker()
}

final class PickerComponent: UIView, PickerComponentProtocol {
    
    @IBOutlet weak var buttonOK: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerView: UIPickerView!
    
    public weak var delegate: PickerDelegateProtocol?
    public var isOpen: Bool? = false
    
    private var countries: [String] = []
    private var isPickerViewDelegate: Bool? = false
    private var pickerViewValue: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    @IBAction func buttonConfirm(_ sender: Any) {
        if self.datePicker.isHidden == false {
            let components = getPickerValue()
            self.delegate?.setDate(components: components)
        } else {
            if pickerViewValue?.isEmpty == true {
                pickerViewValue = countries[0]
            }
            self.delegate?.setCountry(country: pickerViewValue ?? countries[0])
        }
        self.delegate?.hidePickerComponent()
    }
    
    func setDatePicker() {
        self.datePicker.isHidden = false
        self.datePicker.addTarget(self, action: #selector(onDatePickerChange(_ :)), for: .valueChanged)
        self.pickerView.isHidden = true
    }
    
    func setPickerView() {
        self.pickerView.isHidden = false
        self.datePicker.isHidden = true
        self.datePicker.removeTarget(self, action: #selector(onDatePickerChange(_ :)), for: .valueChanged)
        self.pickerView.reloadAllComponents()
        if self.isPickerViewDelegate == false {
            self.pickerView.delegate = self
            self.pickerView.dataSource = self
            self.isPickerViewDelegate = true
        }
    }
    
    @objc func onDatePickerChange(_ datePicker: UIDatePicker) {
        if self.datePicker.isHidden == false {
            let components = getPickerValue()
            self.delegate?.setDate(components: components)
        }
    }
    
    private func getPickerValue() -> DateComponents {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: datePicker.date)
        return components
    }
    
    private func commonInit() {
        let view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "pt_PT").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            countries.append(name)
        }
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
    
    func reload() {
        self.datePicker.setDate(Date(), animated: false)
        self.pickerView.reloadAllComponents()
        self.pickerView.selectRow(0, inComponent: 0, animated: false)
    }
}

extension PickerComponent: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerViewValue = countries[row]
        if self.pickerView.isHidden == false {
            self.delegate?.setCountry(country: pickerViewValue ?? "")
        }
    }
}
