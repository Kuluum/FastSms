//
//  AddSmsVC.swift
//  FastSms
//
//  Created by Kuluum on 14.11.2020.
//

import UIKit

final class AddSmsVC<View: AddSmsView>: BaseViewController<View> {
    
    var onCancel: (()->Void)?
    var onDone: ((_ phoneNumber: String, _ smsText: String) -> Void)?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add new sms"
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancellPressed))
        cancelButton.title = "Cancel"
        let addButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        addButton.title = "Add"
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func cancellPressed() {
        onCancel?()
    }
    
    @objc func donePressed() {
        let phoneNumber = rootView.phoneNumber()
        let smsText = rootView.smsText()
        onDone?(phoneNumber, smsText)
    }
}
