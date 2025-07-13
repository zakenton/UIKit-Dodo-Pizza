//
//  CartUserDefaults.swift
//  Dodo Pizza
//
//  Created by Zakhar on 05.07.25.
//

import Foundation

protocol ICartServiseInput {
    func saveOrIncrementProduct(_ product: CartUserDefault)
    func decrementProduct(_ product: CartUserDefault)
    func incrementProduct(_ product: CartUserDefault)
    func removeProduct(_ product: CartUserDefault)
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
    
    private func saveAll(_ products: [CartUserDefault]) {
        if let data = try? encoder.encode(products) {
            userDefaults.set(data, forKey: cartKey)
        }
        print("Peoducts saved")
    }
    
}


// MARK: - Input
extension CartUserDefaultsService: ICartServiseInput {
    func saveOrIncrementProduct(_ product: CartUserDefault) {
        var products = loadProducts()
        
        if let index = products.firstIndex(where: { $0 == product }) {
            products[index].quantity += product.quantity
        } else {
            products.append(product)
        }
        
        saveAll(products)
    }
    
    func decrementProduct(_ product: CartUserDefault) {
        var products = loadProducts()
        
        if let index = products.firstIndex(where: { $0 == product }) {
            if products[index].quantity > 1 {
                products[index].quantity -= 1
            } else {
                products.remove(at: index)
            }
        }
        
        saveAll(products)
    }
    
    func incrementProduct(_ product: CartUserDefault) {
        var products = loadProducts()
        
        if let index = products.firstIndex(where: { $0 == product }) {
            products[index].quantity += 1
        }
        
        saveAll(products)
    }
    
    func removeProduct(_ product: CartUserDefault) {
        var products = loadProducts()
        products.removeAll(where: { $0 == product })
        saveAll(products)
    }
}


//MARK: - Output
extension CartUserDefaultsService: ICartServiseOutput {
    
    func loadProducts() -> [CartUserDefault] {
        guard let data = userDefaults.data(forKey: cartKey),
              let decoded = try? decoder.decode([CartUserDefault].self, from: data) else {
            return []
        }
        return decoded
    }
}
