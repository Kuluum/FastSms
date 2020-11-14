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
    
    func testSetup() {
        let m1 = SmsModel(phoneNumber: "1", smsText: "text1")
        let m2 = SmsModel(phoneNumber: "2", smsText: "text2")
        let m3 = SmsModel(phoneNumber: "3", smsText: "text3")
        let list = SmsListModel(list: [m1, m2, m3])
        
        self.listModel = list
        
    }
}
