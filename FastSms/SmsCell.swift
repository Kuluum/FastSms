//
//  SmsCell.swift
//  FastSms
//
//  Created by Kuluum on 14.11.2020.
//

import UIKit
import SnapKit


class SmsCell: UITableViewCell {
    
    let smsTextLabel = UILabel()
    let phoneNumberLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initUi()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initUi()
     }
    
    func initUi() {
        
        self.contentView.addSubview(smsTextLabel)
        self.contentView.addSubview(phoneNumberLabel)
        
        smsTextLabel.snp.makeConstraints { (make) -> Void in
            make.leading.trailing.equalTo(contentView).offset(15)
            make.top.equalTo(contentView).offset(10)
        }
        
        phoneNumberLabel.snp.makeConstraints{ (make) -> Void in
            make.leading.trailing.equalTo(smsTextLabel)
            make.top.equalTo(smsTextLabel).offset(10)
            make.bottom.equalTo(contentView).offset(10)
        }
    }
    
    var model: SmsModel?
    
    func config(with model: SmsModel) {
        self.model = model
        
        smsTextLabel.text = model.smsText
        phoneNumberLabel.text = model.phoneNumber
    }
    
    
}
