import Foundation
import UIKit

protocol IDetailRouterInput: AnyObject {
    func closeDetails()
    func routeProductToSave(_ product: IProductDisplayable)
}

final class DetailRouter {
    weak var detailsVC: DetailsVC?
    private let router: IRouter
    
    init(router: IRouter) {
        self.router = router
    }
}

extension DetailRouter: IDetailRouterInput {
    
    func closeDetails() {
        detailsVC?.dismiss(animated: true)
    }
    
    func routeProductToSave(_ product: any IProductDisplayable) {
        router.saveProduct(product)
        closeDetails()
    }
}
