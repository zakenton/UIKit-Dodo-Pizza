//
//  MenuPresenter.swift
//  Dodo Pizza
//
//  Created by Zakhar on 02.07.25.
//

import Foundation

class MenuPresenter {
    
    weak var menuVC: IMenuVCInput?
    
    private let interactor: IMenuInteractorInput
    private let router: IMenuRouter
    
    init(interactor: MenuInteractor, router: IMenuRouter) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: Input
extension MenuPresenter: IMenuPresenterInput {
    func getProducts(by category: CategoryView) {
        interactor.getProducts(by: category)
    }
    
    func getBanners() {
        interactor.getBanners()
    }
    
    func getCategories() {
        interactor.getCategories()
    }
    
    func didSelectProduct(_ product: ProductView) {
        router.showDitailView(product: product)
    }
}

// MARK: Output
extension MenuPresenter: IMenuInteractorOutput {
    func didGetProducts(_ products: [ProductView]) {
        menuVC?.showProducts(products)
    }
    
    func didGetBanners(_ products: [ProductView]) {
        menuVC?.showBanners(products)
    }
    
    func didGetCategories(_ categories: [CategoryView]) {
        menuVC?.showCategories(categories)
    }
}
