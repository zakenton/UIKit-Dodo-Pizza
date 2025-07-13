//
//  DependencyContainer.swift
//  dodo-pizza-project-final
//
//  Created by Zakhar on 29.06.25.
//

import Foundation
import UIKit

final class DependencyContainer {
    private let session: URLSession
    
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    private let userDefaults: UserDefaults
    
    let productsLoader: ProductsLoader
    let bannersLoader: BannersLoader
    let categoriesLoader: CategoriesLoader
    
    let cartServise: CartUserDefaultsService
    
    
    let menuAssembly: MenuAssembly
    let mapAssembly: MapAssembly
    let cartAssembly: CartAssembly
    
    let rootTabBarController: RootTabBarController
    
    init() {
        session = URLSession.shared
        decoder = JSONDecoder()
        encoder = JSONEncoder()
        userDefaults = UserDefaults.standard
        
        productsLoader = ProductsLoader(session: session,
                                        decoder: decoder)
        
        bannersLoader = BannersLoader(session: session,
                                      decoder: decoder)
        
        categoriesLoader = CategoriesLoader(session: session,
                                            decoder: decoder)
        
        cartServise = CartUserDefaultsService(userDefaults: userDefaults, encoder: encoder, decoder: decoder)
        
        menuAssembly = MenuAssembly(productsLoader: productsLoader,
                                  bannersLoader: bannersLoader,
                                    categoriesLoader: categoriesLoader,
                                    cartServise: cartServise)
        
        mapAssembly = MapAssembly()
        
        cartAssembly = CartAssembly()
        
        rootTabBarController = RootTabBarController(menuAssembly: menuAssembly,
                                                    mapAssembly: mapAssembly,
                                                    cartAssembly: cartAssembly)
    }
}
