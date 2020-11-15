//
//  AppRoot.swift
//  FastSms
//
//  Created by Kuluum on 15.11.2020.
//

import UIKit

func createAppRoot() -> (UIViewController, ApplicationCoordinator) {
    
    let rootVC = UINavigationController()
    let router = RouterImp(rootController: rootVC)
    let cooridnator = ApplicationCoordinator(router: router)
    
    return (rootVC, cooridnator)
}
