//
//  SmsCell.swift
//  FastSms
//
//  Created by Kuluum on 14.11.2020.
//

import UIKit
import SnapKit


class SmsCell: UITableViewCell {
    
    var model: SmsModel?
    
    let smsTextLabel = UILabel()
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
     }
    
    func setupUI() {
        contentView.addSubview(smsTextLabel)
        smsTextLabel.font = UIFont(name: "Helvetica", size: 17)
        smsTextLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(contentView).offset(15)
            $0.top.equalTo(contentView).offset(10)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.font = UIFont(name: "Helvetica", size: 15)
        titleLabel.textColor = .gray
        titleLabel.snp.makeConstraints{
            $0.leading.trailing.equalTo(smsTextLabel)
            $0.top.equalTo(smsTextLabel).offset(10)
            $0.bottom.equalTo(contentView).offset(10)
        }
    }
    
    
    func config(with model: SmsModel) {
        self.model = model
        
        smsTextLabel.text = model.smsText
        titleLabel.text = "\(model.name) (\(model.phoneNumber))"
    }
    
    
}
