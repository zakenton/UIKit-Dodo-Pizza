//
//  CartPresenter.swift
//  Dodo Pizza
//
//  Created by Zakhar on 28.07.25.
//

import Foundation


//MARK: Init
final class CartPresenter {
    
    weak var view: CartVC?
    
    private let router: IRouter
    private let interactor: ICartInteractorInput
    
    init(interactor: ICartInteractorInput,router: IRouter) {
        self.router = router
        self.interactor = interactor
    }
}

private extension CartPresenter {
    func setupCartTableView(with products: [ProductCart]) {
        if products.isEmpty {
            view?.showEmptyView()
            return
        }
        
        view?.showTableView()
        view?.tableView.updateProducts(products)
        
        let totalPrice = countTotalPrice(with: products)
        view?.bottomView.setTotalPrice(mapPrice(totalPrice))
    }
    
    func countTotalPrice(with products: [ProductCart]) -> Double {
        return products.reduce(0.0) { total, product in
            var productPrice = product.price
            
            if let selectedDough = product.dough?.first(where: { $0.isSelected }) {
                productPrice += selectedDough.price
            }
            
            if let selectedSize = product.size?.first(where: { $0.isSelected }) {
                productPrice += selectedSize.price
            }
            
            let additivesPrice = product.additive?.reduce(0.0) { sum, additive in
                return additive.isSelected ? sum + additive.price : sum
            } ?? 0.0
            
            productPrice += additivesPrice
            
            return total + (productPrice * Double(product.quantity))
        }
    }
    
    func mapPrice(_ price: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = "."
        
        guard let formattedString = formatter.string(from: NSNumber(value: price)) else {
            return String(format: "%.2f€", price)
        }
        
        return formattedString + "€"
    }
}

// MARK: Input
extension CartPresenter: ICartPresenterInput {
    
    func getAllProducts() {
        interactor.getAllProducts()
    }
    
    func addAdditionalProduct(_ product: ProductCart) {
        router.showDitailView(with: product)
    }
    
    func saveAdditedProduct(_ product: ProductCart) {
        interactor.saveModifiedProduct(product)
    }
    
    func decrementProductQuantity(for cartId: UUID) {
        interactor.decrementProduct(by: cartId)
    }
    
    func incrementProductQuantity(for cartId: UUID) {
        interactor.incrementProduct(by: cartId)
    }
    
    func removeProduct(with cartId: UUID) {
        interactor.removeProducts(by: cartId)
    }
}

// MARK: - Output
extension CartPresenter: ICartInteractorOutput {
    func didLoadPeoducts(_ products: [ProductCart]) {
        setupCartTableView(with: products)
    }
    
    func didChangProductQuantity(by cartId: UUID) {
        
    }
    
    func didRemoveProduct(by cartId: UUID) {
        
    }
}
