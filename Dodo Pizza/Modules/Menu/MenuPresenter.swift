//
//  MenuPresenter.swift
//  Dodo Pizza
//
//  Created by Zakhar on 02.07.25.
//

import Foundation

class MenuPresenter {
    
    weak var menuVC: IMenuVCInput?
    
    private let interactor: IMenuInteractor
    private let router: IMenuRouter
    
    var currentCategory: CategoryView = .pizza
    
    init(interactor: MenuInteractor, router: IMenuRouter) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: Input
extension MenuPresenter: IMenuPresenterInput {
    func viewDidLoad() {
        interactor.loadProducts()
        interactor.loadBanners()
        interactor.loadCategories()
    }
    
    func didSelectProduct(_ product: ProductView) {
        router.showDitailView(product: product)
    }
    
    func didSelectCategory(_ category: CategoryView) {
        currentCategory = category
        interactor.fetchProducts()
    }
    
    func didTapPriceButton() {
        
    }
}

// MARK: Output
extension MenuPresenter: IMenuInteractorOutput {
    
    func didLoadProducts(_ products: [ProductView]) {
        let sorted = products.filter { $0.category == currentCategory }
        menuVC?.showProducts(sorted)
    }
    
    func didLoadBanners(_ banners: [ProductView]) {
        menuVC?.showBanners(banners)
    }
    
    func didLoadCategories(_ categories: [CategoryView]) {
        menuVC?.showCategories(categories, selectedCategory: currentCategory)
    }
    
    func didChangeCategory(_ products: [ProductView]) {
        let sorted = products.filter { $0.category == currentCategory }
        menuVC?.selectCategory(sorted, selectedCategory: currentCategory)
    }
}
