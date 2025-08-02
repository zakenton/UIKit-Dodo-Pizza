//
//  DetailRouter.swift
//  Dodo Pizza
//
//  Created by Zakhar on 06.07.25.
//

import Foundation
import UIKit

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
