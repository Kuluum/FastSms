//
//  AppDelegate.swift
//  FastSms
//
//  Created by Kuluum on 12.11.2020.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        
        let m1 = SmsModel(phoneNumber: "1", smsText: "text1")
        let m2 = SmsModel(phoneNumber: "2", smsText: "text2")
        let m3 = SmsModel(phoneNumber: "3", smsText: "text3")
        let list = SmsListModel(list: [m1, m2, m3])
        
        let initialViewController = FastSMSTableViewController(style: .grouped)
        initialViewController.config(with: list)
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()

        return true
    }


}

