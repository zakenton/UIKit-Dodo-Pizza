//
//  MenuRouter.swift
//  Dodo Pizza
//
//  Created by Zakhar on 02.07.25.
//

import Foundation
import UIKit


final class MenuRouter {
    
    weak var menuVC: MenuVC?
    weak var menuPresenter: IMenuPresenterInput?
}

extension MenuRouter: IMenuRouter {
    func saveProduct(_ product: ProductView) {
        menuPresenter?.saveProduct(product)
    }
    
    func showDitailView(with product: ProductView) {
        let detailsVC = DetailBuilder.build(product: product, router: self)
        menuVC?.present(detailsVC, animated: true)
    }
}
