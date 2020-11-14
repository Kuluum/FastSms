//
//  BaseViewController.swift
//  FastSms
//
//  Created by Kuluum on 14.11.2020.
//

import UIKit

class BaseViewController<View: UIView>: UIViewController {
    
    typealias OnBackButtonTap = () -> Void
    
    var rootView: View { view as! View }
    var onBackButtonTap: OnBackButtonTap?
    
    override func loadView() {
        view = View.init(frame: UIScreen.main.bounds)
    }
}
