//
//  AddSmsVC.swift
//  FastSms
//
//  Created by Kuluum on 14.11.2020.
//

import UIKit

final class AddSmsVC<View: AddSmsView>: BaseViewController<View> {
    
    var onCancel: (()->Void)?
    var onDone: ((_ phoneNumber: String, _ name: String, _ smsText: String) -> Void)?
    var onOpenContact: (()->Void)?
    
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
        
        rootView.onContactsPress = onOpenContact
    }
    
    public func fill(phone: String, name: String) {
        rootView.fill(phoneNumber: phone, name: name)
    }
    
    @objc private func cancellPressed() {
        onCancel?()
    }
    
    @objc private func donePressed() {
        let phoneNumber = rootView.phoneNumber()
        let smsText = rootView.smsText()
        let name = rootView.name()
        onDone?(phoneNumber, name, smsText)
    }
}
