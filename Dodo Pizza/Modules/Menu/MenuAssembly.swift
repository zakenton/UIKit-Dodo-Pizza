//
//  MenuBuilder.swift
//  Dodo Pizza
//
//  Created by Zakhar on 02.07.25.
//

import Foundation
import UIKit

final class MenuAssembly {
    private let productsLoader: IProductsLoader
    private let bannersLoader: IBannersLoader
    private let categoriesLoader: ICategoriesLoader
    private let cartServise: ICartServiseInput
    
    init(productsLoader: IProductsLoader, bannersLoader: IBannersLoader, categoriesLoader: ICategoriesLoader, cartServise: ICartServiseInput) {
        self.productsLoader = productsLoader
        self.bannersLoader = bannersLoader
        self.categoriesLoader = categoriesLoader
        self.cartServise = cartServise
    }
    
    func build() -> UIViewController {
        let router = MenuRouter(cartServise: cartServise)
        
        let interector = MenuInteractor(productsLoader: productsLoader,
                                        bannersLoader: bannersLoader,
                                        categoriesLoader: categoriesLoader)
        
        let presenter = MenuPresenter(interactor: interector,
                                      router: router)
        
        let menuVC = MenuVC(presenter: presenter)
        
        menuVC.tabBarItem = UITabBarItem(title: "Menu",
                                        image: UIImage(systemName: "menucard"),
                                        selectedImage: UIImage(systemName: "menucard"))
        
        presenter.menuVC = menuVC
        
        interector.presenter = presenter
        
        router.menuVC = menuVC
        
        return menuVC
    }
}
