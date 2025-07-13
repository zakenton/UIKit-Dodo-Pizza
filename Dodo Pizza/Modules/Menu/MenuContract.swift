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
    func showCategories(_ categories: [CategoryView], selectedCategory: CategoryView)
    func selectCategory(_ products: [ProductView], selectedCategory: CategoryView)
}

protocol IMenuInteractor: AnyObject {
    
    func loadProducts()
    func loadBanners()
    func loadCategories()
    
    func fetchProducts()
    func fetchBanners()
    func fetchCategories()
}

protocol IMenuPresenterInput: AnyObject {
    func viewDidLoad()
    func didSelectProduct(_ product: ProductView)
    func didSelectCategory(_ category: CategoryView)
    func didTapPriceButton()
    var currentCategory: CategoryView { get }
}

protocol IMenuInteractorOutput: AnyObject {
    func didLoadProducts(_ products: [ProductView])
    func didLoadBanners(_ banners: [ProductView])
    func didLoadCategories(_ categories: [CategoryView])
    func didChangeCategory(_ products: [ProductView])
}
