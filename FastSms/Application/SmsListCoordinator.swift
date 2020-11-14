//
//  SmsListCoordinator.swift
//  FastSms
//
//  Created by Kuluum on 14.11.2020.
//

import UIKit
import MessageUI

@objc
final class SmsListCoordinator: BaseCoordinator, MFMessageComposeViewControllerDelegate {
    
    private let router: Router
    
    private var smsListProvider: SmsListModelProvider
    private weak var smsTableControlelr: SmsTableViewController?
    
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
        
        smsTableVc.onsSendClick = { [weak self] (smsModel) in
            self?.sendText(phonenumber: smsModel.phoneNumber, text: smsModel.smsText)
        }
        
        router.setRootModule(smsTableVc, hideBar: true)
        self.smsTableControlelr = smsTableVc
    }
    
    private func showAddSms() {
        let vc = AddSmsVC()
        vc.onCancel = { [weak router] in
            router?.dismissModule()
        }
        
        vc.onDone = {  [weak self, weak router] (phoneNumber, smsText) in
            let model = SmsModel(phoneNumber: phoneNumber, smsText: smsText)
            self?.smsListProvider.append(model)
            self?.reconfigSmsTable()
            router?.dismissModule()
        }
    
        
        // TODO: Looks like router cant make modal+navigation+moDalstyle itself, maybe add such medod will be ok.
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .formSheet
        router.present(nav)
    }
    
    private func reconfigSmsTable() {
        self.smsTableControlelr?.config(with: self.smsListProvider.listModel)
    }
    
    func sendText(phonenumber: String, text: String) {
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = "Message Body"
            controller.recipients = [phonenumber]
            controller.messageComposeDelegate = self
            
            router.present(controller)
        } else {
            let alert = UIAlertController(title: "Cant send sms", message: "Meh(", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))

            router.present(alert)
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController!, didFinishWith result: MessageComposeResult) {
        router.dismissModule()
    }
}
