import Foundation

protocol ICartServiseInput {
    func saveOrIncrementProduct(_ product: ProductCart)
    func decrementProduct(by cartId: UUID)
    func incrementProduct(by cartId: UUID)
    func removeProducts(by cartId: UUID)
    func clearCart()
}

protocol ICartServiseOutput {
    func loadProducts() -> [ProductCart]
}

final class CartService {
    
    private let cartKey = "cart_products"
    private let userDefaults: UserDefaults
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    
    init(userDefaults: UserDefaults = .standard,
         encoder: JSONEncoder = JSONEncoder(),
         decoder: JSONDecoder = JSONDecoder()) {
        self.userDefaults = userDefaults
        self.encoder = encoder
        self.decoder = decoder
    }
    
    // MARK: - Private Methods
    
    private func getAllProducts() -> [ProductCart] {
        guard let data = userDefaults.data(forKey: cartKey),
              let decoded = try? decoder.decode([ProductCart].self, from: data) else {
            return []
        }
        return decoded
    }
    
    private func saveAllProducts(_ products: [ProductCart]) {
        if let data = try? encoder.encode(products) {
            userDefaults.set(data, forKey: cartKey)
        }
    }
}

// MARK: - ICartServiseInput
extension CartService: ICartServiseInput {
    
    func saveOrIncrementProduct(_ product: ProductCart) {
        var products = getAllProducts()
        
        // Находим индекс продукта с такими же характеристиками
        if let index = products.firstIndex(where: { existingProduct in
            return existingProduct.productId == product.productId &&
            existingProduct.dough == product.dough &&
            existingProduct.size == product.size &&
            existingProduct.additive == product.additive
        }) {
            // Увеличиваем количество
            products[index].quantity += product.quantity
        } else {
            // Добавляем новый продукт
            products.append(product)
        }
        
        saveAllProducts(products)
    }
    
    func decrementProduct(by cartId: UUID) {
        var products = getAllProducts()
        
        if let index = products.firstIndex(where: { $0.cartItemId == cartId }) {
            if products[index].quantity > 1 {
                products[index].quantity -= 1
            } else {
                products.remove(at: index)
            }
            saveAllProducts(products)
        }
    }
    
    func incrementProduct(by cartId: UUID) {
        var products = getAllProducts()
        
        if let index = products.firstIndex(where: { $0.cartItemId == cartId }) {
            products[index].quantity += 1
            saveAllProducts(products)
        }
    }
    
    func removeProducts(by cartId: UUID) {
        var products = getAllProducts()
        products.removeAll { $0.cartItemId == cartId }
        saveAllProducts(products)
    }
    
    func clearCart() {
        userDefaults.removeObject(forKey: cartKey)
    }
}

// MARK: - ICartServiseOutput
extension CartService: ICartServiseOutput {
    func loadProducts() -> [ProductCart] {
        return getAllProducts()
    }
}
