//
//  CartInteractor.swift
//  Dodo Pizza
//
//  Created by Zakhar on 28.07.25.
//

import Foundation

// MARK: Init
final class CartInteractor {
    weak var presenter: ICartInteractorOutput?
    
    private let cartServise: CartService
    
    init(cartServise: CartService) {
        self.cartServise = cartServise
    }
}

// MARK: - Private Logic
private extension CartInteractor {
    /// Modified prodcut have UUID as cartItemId.
    func makeProductWithNewId(form product: ProductCart) -> ProductCart {
        return ProductCart(productId: product.productId,
                           cartItemId: UUID(),
                           name: product.name,
                           description: product.description,
                           price: product.price,
                           imageURL: product.imageURL,
                           dough: product.dough,
                           size: product.size,
                           additive: product.additive,
                           quantity: 1)
    }
}

// MARK: - Input
extension CartInteractor: ICartInteractorInput {
    func getAllProducts() {
        let products = cartServise.loadProducts()
        presenter?.didLoadPeoducts(products)
    }
    
    func saveModifiedProduct(_ product: ProductCart) {
        let modifiedProductCartId = product.cartItemId
        cartServise.decrementProduct(by: modifiedProductCartId)
        
        let newProdutc = makeProductWithNewId(form: product)
        cartServise.saveOrIncrementProduct(newProdutc)
        
        let products = cartServise.loadProducts()
        presenter?.didLoadPeoducts(products)
    }
    
    func decrementProduct(by cartId: UUID) {
        cartServise.decrementProduct(by: cartId)
        
        let products = cartServise.loadProducts()
        presenter?.didLoadPeoducts(products)
    }
    
    func incrementProduct(by cartId: UUID) {
        cartServise.incrementProduct(by: cartId)
        
        let products = cartServise.loadProducts()
        presenter?.didLoadPeoducts(products)
    }
    
    func removeProducts(by cartId: UUID) {
        cartServise.removeProducts(by: cartId)
        
        let products = cartServise.loadProducts()
        presenter?.didLoadPeoducts(products)
    }
}
