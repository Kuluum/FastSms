//
//  SmsModel.swift
//  FastSms
//
//  Created by Kuluum on 14.11.2020.
//

import Foundation

struct SmsModel: Codable {
    let phoneNumber: String
    let name: String
    let smsText: String
}
