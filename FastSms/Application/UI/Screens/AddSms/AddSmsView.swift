//
//  AddSmsView.swift
//  FastSms
//
//  Created by Kuluum on 14.11.2020.
//

import UIKit
import SnapKit

final class AddSmsView: UIView {
    
    private let phoneTextField = UITextField()
    private let smsTextField = UITextField()
    
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
        
        addSubview(phoneTextField)
        phoneTextField.borderStyle = .roundedRect
        phoneTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide).inset(20)
            make.left.right.equalTo(safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        addSubview(smsTextField)
        smsTextField.borderStyle = .roundedRect
        smsTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(phoneTextField.snp.bottom).offset(15)
            make.left.right.equalTo(phoneTextField)
            make.height.equalTo(40)
        }
        
        phoneTextField.placeholder = "phone number"
        smsTextField.placeholder = "sms text"
    }
    
    func phoneNumber() -> String {
        return phoneTextField.text ?? ""
    }
    
    func smsText() -> String {
        return smsTextField.text ?? ""
    }
}
