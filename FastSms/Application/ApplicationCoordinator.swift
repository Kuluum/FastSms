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
        
        let provider: SmsListModelProvider = SmsListModelProviderUserDefault()
        
        let coordinator = SmsListCoordinator(router: router, provider: provider)
        self.addDependency(coordinator)
        coordinator.start()
    }
    
}
