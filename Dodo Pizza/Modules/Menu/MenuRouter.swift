//
//  MenuRouter.swift
//  Dodo Pizza
//
//  Created by Zakhar on 02.07.25.
//

import Foundation
import UIKit


final class MenuRouter: IMenuRouter {
    
    weak var menuVC: MenuVC?
    
    private let cartServise: ICartServiseInput
    
    init(cartServise: ICartServiseInput) {
        self.cartServise = cartServise
    }
    
    func showDitailView(product: ProductView) {
        let detailsVC = DetailBuilder.build(product: product, cartService: cartServise)
        menuVC?.present(detailsVC, animated: true)
    }
}
