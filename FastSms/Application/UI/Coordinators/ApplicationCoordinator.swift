import Foundation

final class ApplicationCoordinator: BaseCoordinator {
    
    private let router: Router
    
    init(router: Router) {
        self.router = router
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
