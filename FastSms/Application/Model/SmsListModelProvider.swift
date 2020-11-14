//
//  SmsListProvider.swift
//  FastSms
//
//  Created by Kuluum on 14.11.2020.
//

import Foundation

protocol SmsListModelProvider {
    var listModel: SmsListModel { get }
    
    func append(_ smsModel: SmsModel)
}

class SmsListModelProviderUserDefault: SmsListModelProvider {
    var listModel: SmsListModel
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let defaults = UserDefaults.standard
    
    init() {
        if let savedList = defaults.object(forKey: "SmsListModel") as? Data,
        let loadedList = try? decoder.decode(SmsListModel.self, from: savedList) {
            listModel = loadedList
            return
        }
        
        listModel = SmsListModel(list: Array<SmsModel>())
    }
    
    func append(_ smsModel: SmsModel) {
        listModel = listModel.appending(sms: smsModel)
        
        if let encoded = try? encoder.encode(listModel) {
            defaults.set(encoded, forKey: "SmsListModel")
        } else {
            print("Encode failed")
        }
    }
        
}
