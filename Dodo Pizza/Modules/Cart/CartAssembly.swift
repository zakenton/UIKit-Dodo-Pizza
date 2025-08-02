//
//  CartBuilder.swift
//  Dodo Pizza
//
//  Created by Zakhar on 03.07.25.
//

import Foundation
import UIKit

final class CartAssembly {
    
    private let cartServise: CartService
    
    init(cartServise: CartService) {
        self.cartServise = cartServise
    }
}

extension CartAssembly {
    func build() -> UIViewController {
        
        let router = CartRouter()
        
        let interactor = CartInteractor(cartServise: cartServise)
        
        let presenter = CartPresenter(interactor: interactor, router: router)
        
        let cartVC = CartVC(presenter: presenter)
        
        cartVC.tabBarItem = UITabBarItem(title: "Cart",
                                          image: UIImage(systemName: "cart"),
                                          selectedImage: UIImage(systemName: "cart"))
        
        interactor.presenter = presenter
        
        presenter.view = cartVC
        router.cartVC = cartVC
        router.cartPresenter = presenter
        
        return cartVC
    }
}
