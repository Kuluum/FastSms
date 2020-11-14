//
//  SmsListProvider.swift
//  FastSms
//
//  Created by Kuluum on 14.11.2020.
//

import Foundation

class SmsListModelProvider {
    var listModel: SmsListModel?
    
    func append(_ smsModel: SmsModel) {
        listModel = listModel?.appending(sms: smsModel)
    }
}
