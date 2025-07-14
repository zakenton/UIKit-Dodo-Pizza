//
//  MenuContract.swift
//  Dodo Pizza
//
//  Created by Zakhar on 10.07.25.
//

import Foundation

protocol IMenuRouter: AnyObject {
    func showDitailView(product: ProductView)
}

protocol IMenuVCInput: AnyObject {
    func showProducts(_ products: [ProductView])
    func showBanners(_ banners: [ProductView])
    func showCategories(_ categories: [CategoryView])
}

protocol IMenuPresenterInput: AnyObject {
    func getProducts(by category: CategoryView)
    func getBanners()
    func getCategories()
    func didSelectProduct(_ product: ProductView)
}

protocol IMenuInteractorInput: AnyObject {
    func getProducts(by category: CategoryView)
    func getBanners()
    func getCategories()
}

protocol IMenuInteractorOutput: AnyObject {
    func didGetProducts(_ products: [ProductView])
    func didGetBanners(_ products: [ProductView])
    func didGetCategories(_ categories: [CategoryView])
}
