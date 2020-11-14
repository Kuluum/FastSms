//
//  SmsListModel.swift
//  FastSms
//
//  Created by Kuluum on 14.11.2020.
//

import Foundation

struct SmsListModel: Codable {
    let list: Array<SmsModel>
    
    func appending(sms: SmsModel) -> SmsListModel {
        let newList = list + [sms]
        return SmsListModel(list: newList)
    }
}
