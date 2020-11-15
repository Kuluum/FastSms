//
//  SmsListCoordinator.swift
//  FastSms
//
//  Created by Kuluum on 14.11.2020.
//

import UIKit
import MessageUI
import ContactsUI


@objc
final class SmsListCoordinator: BaseCoordinator {
    
    private let router: Router
    
    private var smsListProvider: SmsListModelProvider
    private weak var smsTableControlelr: SmsTableViewController?
    private weak var addSmsVc: AddSmsVC<AddSmsView>?
    
    init(router: Router, provider: SmsListModelProvider) {
        self.router = router
        self.smsListProvider = provider
    }
    
    override func start() {
        runStartFlow()
    }
    
    private func runStartFlow() {
        let smsTableVc = SmsTableViewController(style: .grouped)
        smsTableVc.config(with: smsListProvider.listModel)
     
        smsTableVc.onAddSms = { [weak self] in
            self?.showAddSms()
        }
        
        smsTableVc.onSendClick = { [weak self] (smsModel) in
            self?.sendText(phonenumber: smsModel.phoneNumber, text: smsModel.smsText)
        }
        
        smsTableVc.onDeleteSms = { [weak self] (deleteIndex) in
            self?.smsListProvider.delete(at: deleteIndex)
            self?.reconfigSmsTable()
        }
        
        router.setRootModule(smsTableVc, hideBar: true)
        self.smsTableControlelr = smsTableVc
    }
    
    private func showAddSms() {
        let vc = AddSmsVC()
        vc.onCancel = { [weak router] in
            router?.dismissModule()
        }

        vc.onDone = {  [weak self, weak router] (phoneNumber, name, smsText) in
            let model = SmsModel(phoneNumber: phoneNumber, name: name, smsText: smsText)
            self?.smsListProvider.append(model)
            self?.reconfigSmsTable()
            router?.dismissModule()
            self?.addSmsVc = nil
        }

        vc.onOpenContact = { [weak self] in
            self?.showSelectContact()
        }
        
        // TODO: Looks like router cant make modal+navigation+moDalstyle itself, maybe add such medod will be ok.
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .formSheet
        router.present(nav)
        
        self.addSmsVc = vc
    }
    
    private func reconfigSmsTable() {
        self.smsTableControlelr?.config(with: self.smsListProvider.listModel)
    }
    


}

extension SmsListCoordinator: MFMessageComposeViewControllerDelegate {
    
    func sendText(phonenumber: String, text: String) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = text
            controller.recipients = [phonenumber]
            controller.messageComposeDelegate = self
            
            router.present(controller)
        } else {
            let alert = UIAlertController(title: "Cant send sms", message: "Meh(", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            router.present(alert)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        router.dismissModule()
    }
}

extension SmsListCoordinator: CNContactPickerDelegate {
    
    func showSelectContact() {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        
        addSmsVc?.present(contactPicker, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        guard let contact = contacts.first else { return }
        let phone = contact.phoneNumbers.first?.value.stringValue ?? "wrong phone"
        let name = contact.givenName
        
        addSmsVc?.fill(phone: phone, name: name)
        print(name, phone)
    }

}
