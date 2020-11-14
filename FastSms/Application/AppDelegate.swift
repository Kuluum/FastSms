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
    private var appCoordinator: Coordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = UINavigationController()
        let router = RouterImp(rootController: rootVC)
        let cooridnator = ApplicationCoordinator(router: router)

        window.rootViewController = rootVC
        window.makeKeyAndVisible()
        
        cooridnator.start()
        
        self.window = window
        appCoordinator = cooridnator
        
        return true
    }


}

