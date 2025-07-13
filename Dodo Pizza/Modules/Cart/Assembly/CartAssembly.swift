//
//  CartBuilder.swift
//  Dodo Pizza
//
//  Created by Zakhar on 03.07.25.
//

import Foundation
import UIKit

final class CartAssembly {
    
    init() {

    }
    
    func build() -> UIViewController {
        let cartVC = CartVC()
        cartVC.tabBarItem = UITabBarItem(title: "Cart",
                                          image: UIImage(systemName: "cart"),
                                          selectedImage: UIImage(systemName: "cart"))
        
        return cartVC
    }
}
