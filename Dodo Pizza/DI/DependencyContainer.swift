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
    
    let productsLoader: LoaderService
    let addressLoader: AddressLoaderService
    let cartServise: CartService
    
    
    let menuAssembly: MenuAssembly
    let mapAssembly: MapAssembly
    let cartAssembly: CartAssembly
    
    let rootTabBarController: RootTabBarController
    
    init() {
        session = URLSession.shared
        decoder = JSONDecoder()
        encoder = JSONEncoder()
        userDefaults = UserDefaults.standard
        
        productsLoader = LoaderService(session: session, decoder: decoder)
        addressLoader = AddressLoaderService(session: session, decoder: decoder)
        cartServise = CartService(userDefaults: userDefaults, encoder: encoder, decoder: decoder)
        
        menuAssembly = MenuAssembly(loaderService: productsLoader, cartServise: cartServise)
        
        mapAssembly = MapAssembly(addressLoader: addressLoader)
        
        cartAssembly = CartAssembly(cartServise: cartServise)
        
        rootTabBarController = RootTabBarController(menuAssembly: menuAssembly,
                                                    mapAssembly: mapAssembly,
                                                    cartAssembly: cartAssembly)
    }
}
