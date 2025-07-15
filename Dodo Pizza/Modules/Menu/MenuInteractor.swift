//
//  MenuManager.swift
//  dodo-pizza-work
//
//  Created by Zakhar on 30.06.25.
//

import Foundation

final class MenuInteractor {
    
    weak var presenter: IMenuInteractorOutput?
    
    private var products: [CategoryView: [ProductView]] = [:]
    private var banners: [ProductView] = []
    private var categories: [CategoryView] = []
    
    private let loaderService: ILoaderService
    private let cartServise: ICartServiseInput
    
    init(loaderService: ILoaderService, cartServise: ICartServiseInput) {
        self.loaderService = loaderService
        self.cartServise = cartServise
    }
}

//MARK: Logic
private extension MenuInteractor {

    
}

//MARK: Loaders
private extension MenuInteractor {
    
    func loadProducts(by category: CategoryView) {
        loaderService.getProducts(by: category) { [weak self] products in
            guard let self = self else { return }
            
            self.products[category] = products
            DispatchQueue.main.async {
                self.presenter?.didGetProducts(products)
            }
        }
    }
    
    func loadBanners() {
        loaderService.getBanners { [weak self] banners in
            guard let self = self else { return }
            
            self.banners = banners
            DispatchQueue.main.async {
                self.presenter?.didGetBanners(banners)
            }
        }
    }
    
    func loadCategories() {
        print(3)
        loaderService.getCategories { [weak self] categories in
            guard let self = self else { return }
            
            self.categories = categories
            DispatchQueue.main.async {
                self.presenter?.didGetCategories(categories)
            }
        }
    }
}

extension MenuInteractor: IMenuInteractorInput {
    func getProducts(by category: CategoryView) {
        if let cached = products[category] {
            presenter?.didGetProducts(cached)
        } else {
            loadProducts(by: category)
        }
    }
    
    func getBanners() {
        if banners.isEmpty {
            loadBanners()
        } else {
            presenter?.didGetBanners(banners)
        }
    }
    
    func getCategories() {
        if categories.isEmpty {
            loadCategories()
        } else {
            presenter?.didGetCategories(categories)
        }
    }
    
    func saveProduct(_ product: ProductView) {
        let cartProduct = product.toCartUserDefaults()
        cartServise.saveOrIncrementProduct(cartProduct)
        print("Product saved: " + product.name)
    }
}
