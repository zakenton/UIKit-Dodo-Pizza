//
//  CartContract.swift
//  Dodo Pizza
//
//  Created by Zakhar on 28.07.25.
//

import Foundation

protocol ICartVCInput: AnyObject {
    func fetchProduct(_ product: ProductCart)
}

protocol ICartPresenterInput: AnyObject {
    func getAllProducts()
    func addAdditionalProduct(_ product: ProductCart)
    func saveAdditedProduct(_ product: ProductCart)
    func decrementProductQuantity(for cartId: UUID)
    func incrementProductQuantity(for cartId: UUID)
    func removeProduct(with cartId: UUID)
}

protocol ICartInteractorInput: AnyObject {
    func getAllProducts()
    func saveModifiedProduct(_ product: ProductCart)
    func decrementProduct(by cartId: UUID)
    func incrementProduct(by cartId: UUID)
    func removeProducts(by cartId: UUID)
}

protocol ICartInteractorOutput: AnyObject {
    func didLoadPeoducts(_ products: [ProductCart])
    func didChangProductQuantity(by cartId: UUID)
    func didRemoveProduct(by cartId: UUID)
}
