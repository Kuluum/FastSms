import Foundation

final class ApplicationCoordinator: BaseCoordinator {
    
//    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    
    init(router: Router/*, coordinatorFactory: CoordinatorFactory*/) {
        self.router = router
//        self.coordinatorFactory = coordinatorFactory
    }
    
    override func start() {
        runStartFlow()
    }
    
    private func runStartFlow() {
        let m1 = SmsModel(phoneNumber: "1", smsText: "text1")
        let m2 = SmsModel(phoneNumber: "2", smsText: "text2")
        let m3 = SmsModel(phoneNumber: "3", smsText: "text3")
        let list = SmsListModel(list: [m1, m2, m3])
        let provider = SmsListModelProvider()
        provider.listModel = list
        
        let coordinator = SmsListCoordinator(router: router, provider: provider)
        self.addDependency(coordinator)
        coordinator.start()
    }
    
}
