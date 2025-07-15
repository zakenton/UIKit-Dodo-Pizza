//
//  CartUserDefaults.swift
//  Dodo Pizza
//
//  Created by Zakhar on 05.07.25.
//

import Foundation

protocol ICartServiseInput {
    func saveOrIncrementProduct(_ product: CartUserDefault)
    func decrementProduct(by cartId: UUID)
    func incrementProduct(by cartId: UUID)
    func removeProducts(by cartId: UUID)
    func clearCart()
}

protocol ICartServiseOutput {
    func loadProducts() -> [CartUserDefault]
}

final class CartUserDefaultsService {
    
    private let cartKey = "cart_items"
    private let userDefaults: UserDefaults
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    
    init(userDefaults: UserDefaults, encoder: JSONEncoder, decoder: JSONDecoder) {
        self.userDefaults = userDefaults
        self.encoder = encoder
        self.decoder = decoder
    }
}

// MARK: - Input
extension CartUserDefaultsService: ICartServiseInput {
    func saveOrIncrementProduct(_ product: CartUserDefault) {
        var products = getAll()
        
        if let index = products.firstIndex(where: {
            $0.productId == product.productId &&
            $0.dough == product.dough &&
            $0.optins == product.optins &&
            $0.additives == product.additives
        })  {
            products[index].quantity += product.quantity
            print("Product \(products[index].productId) quantity: \(products[index].quantity) ")
        } else {
            products.append(product)
            print("Added new product to cart")
        }
        
        setAll(products)
    }
    
    func decrementProduct(by cartId: UUID) {
        var products = getAll()
        
        if let index = products.firstIndex(where: {$0.cartItemId == cartId}) {
            if products[index].quantity > 1 {
                products[index].quantity -= 1
            } else {
                products.remove(at: index)
            }
            setAll(products)
        }
    }
    
    func incrementProduct(by cartId: UUID) {
        var products = getAll()
        
        if let index = products.firstIndex(where: {$0.cartItemId == cartId}) {
            products[index].quantity += 1
            setAll(products)
        }
    }
    
    func removeProducts(by cartId: UUID) {
        var products = getAll()
        
        products.removeAll { $0.cartItemId == cartId }
        
        setAll(products)
    }
    
    func clearCart() {
        deleteAll()
        print("Cart is clear")
    }
}


//MARK: - Output
extension CartUserDefaultsService: ICartServiseOutput {
    
    func loadProducts() -> [CartUserDefault] {
        return getAll()
    }
}

//MARK: Logic
private extension CartUserDefaultsService {
    func setAll(_ products: [CartUserDefault]) {
        if let data = try? encoder.encode(products) {
            userDefaults.set(data, forKey: cartKey)
        }
        print("Products saved: \(products.count)")
    }
    
    func getAll() -> [CartUserDefault] {
        guard let data = userDefaults.data(forKey: cartKey),
              let decoded = try? decoder.decode([CartUserDefault].self, from: data) else {
            return []
        }
        return decoded
    }
    
    func deleteAll() {
        userDefaults.removeObject(forKey: cartKey)
    }
}
