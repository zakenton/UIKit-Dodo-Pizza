//
//  MenuBuilder.swift
//  Dodo Pizza
//
//  Created by Zakhar on 02.07.25.
//

import Foundation
import UIKit

final class MenuAssembly {
    private let loaderService: ILoaderService
    private let cartServise: ICartServiseInput
    
    init(loaderService: ILoaderService, cartServise: ICartServiseInput) {
        self.loaderService = loaderService
        self.cartServise = cartServise
    }
    
    func build() -> UIViewController {
        let router = MenuRouter(cartServise: cartServise)
        
        let interector = MenuInteractor(loaderService: loaderService)
        
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
