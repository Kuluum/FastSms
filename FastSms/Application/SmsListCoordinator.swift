//
//  SmsListCoordinator.swift
//  FastSms
//
//  Created by Kuluum on 14.11.2020.
//

import UIKit

final class SmsListCoordinator: BaseCoordinator {
    
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
        if let listModel = smsListProvider.listModel {
            smsTableVc.config(with: listModel)
        }
     
        smsTableVc.onAddSms = { [weak self] in
            self?.showAddSms()
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
        if let listModel = smsListProvider.listModel {
            self.smsTableControlelr?.config(with: listModel)
        }
    }
    
}
