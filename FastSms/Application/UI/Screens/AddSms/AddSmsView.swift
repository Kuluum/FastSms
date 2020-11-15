//
//  AddSmsView.swift
//  FastSms
//
//  Created by Kuluum on 14.11.2020.
//

import UIKit
import SnapKit

final class AddSmsView: UIView {
    
    public var onContactsPress: (()->Void)?
    
    private let phoneTextField = UITextField()
    private let nameTextField = UITextField()
    private let smsTextField = UITextField()
    
    private let contactButton = UIButton(type: .roundedRect)
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup() {
        backgroundColor = .groupTableViewBackground
        
        addSubview(contactButton)
        contactButton.setBackgroundImage(UIImage(named: "phone-book"), for: .normal)
        contactButton.addTarget(self, action: #selector(contactsPress), for: .touchUpInside)
        contactButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).inset(40)
            $0.left.equalTo(safeAreaLayoutGuide).inset(20)
            $0.height.width.equalTo(40)
        }
        
        addSubview(phoneTextField)
        phoneTextField.borderStyle = .roundedRect
        phoneTextField.placeholder = "Phone number"
        phoneTextField.keyboardType = .phonePad
        phoneTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide).inset(20)
            make.left.equalTo(contactButton.snp.right).offset(20)
            make.right.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        addSubview(nameTextField)
        nameTextField.borderStyle = .roundedRect
        nameTextField.placeholder = "Name"
        nameTextField.snp.makeConstraints {
            $0.top.equalTo(phoneTextField.snp.bottom).offset(10)
            $0.left.right.height.equalTo(phoneTextField)
        }
        
        addSubview(smsTextField)
        smsTextField.borderStyle = .roundedRect
        smsTextField.placeholder = "Sms text"
        smsTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(nameTextField.snp.bottom).offset(15)
            make.left.right.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
    }
    
    func fill(phoneNumber: String, name: String) {
        phoneTextField.text = phoneNumber
        nameTextField.text = name
    }
    
    func phoneNumber() -> String {
        return phoneTextField.text ?? ""
    }
    
    func smsText() -> String {
        return smsTextField.text ?? ""
    }
    
    func name() -> String {
        return nameTextField.text ?? ""
    }
    
    @objc func contactsPress() {
        onContactsPress?()
    }
}
