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

extension MenuRouter: IRouter {
    func saveProduct(_ product: IProductDisplayable) {
        menuPresenter?.saveProduct(product as! ProductView)
    }
    
    func showDitailView(with product: IProductDisplayable) {
        let detailsVC = DetailBuilder.build(product: product, router: self)
        menuVC?.present(detailsVC, animated: true)
    }
}
