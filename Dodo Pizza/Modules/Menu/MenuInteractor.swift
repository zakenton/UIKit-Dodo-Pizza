//
//  MenuManager.swift
//  dodo-pizza-work
//
//  Created by Zakhar on 30.06.25.
//

import Foundation


final class MenuInteractor: IMenuInteractor {
    
    weak var presenter: IMenuInteractorOutput?
    
    private let categoriesLoader: ICategoriesLoader
    private let productsLoader: IProductsLoader
    private let bannersLoader: IBannersLoader
    
    var currentCategory: CategoryView = .pizza
    
    var products: [ProductView] = [] {
        didSet {
            presenter?.didLoadProducts(products)
        }
    }
    
    var banners: [ProductView] = [] {
        didSet {
            presenter?.didLoadBanners(banners)
        }
    }
    
    var categories: [CategoryView] = [] {
        didSet {
            presenter?.didLoadCategories(categories)
        }
    }
    
    init(productsLoader: IProductsLoader, bannersLoader: IBannersLoader, categoriesLoader: ICategoriesLoader) {
        self.categoriesLoader = categoriesLoader
        self.productsLoader = productsLoader
        self.bannersLoader = bannersLoader
    }
    
    func loadProducts() {
        print(1)
        productsLoader.loadProducts { [weak self] result in
            switch result {
            case .success(let products):
                let mappedProducts = products.compactMap { $0.toProductMenu() }
                self?.products = mappedProducts
            case .failure(let error):
                print("Error loading products: \(error)")
            }
        }
    }
    
    func loadBanners() {
        print(2)
        bannersLoader.loadBanners { [weak self] result in
            switch result {
            case .success(let products):
                let mappedBanners = products.compactMap { $0.toProductMenu() }
                self?.banners = mappedBanners
            case .failure(let error):
                print("Error loading banners: \(error)")
            }
        }
    }
    
    func loadCategories() {
        print(3)
        categoriesLoader.loadCategories { [weak self] result in
            switch result {
            case .success(let categories):
                let mappedCategories = categories.compactMap { $0.toCategoryMenu()}
                self?.categories = mappedCategories
            case .failure(let error):
                print("Error loading categories: \(error)")
            }
        }
    }
    
    func fetchProducts() {
        presenter?.didChangeCategory(products)
    }
    
    func fetchBanners() {
        
    }
    
    func fetchCategories() {
        
    }
}
