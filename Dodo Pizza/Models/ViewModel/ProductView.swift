//
//  Product.swift
//  dodo-pizza-project-final
//
//  Created by Zakhar on 28.06.25.
//

import Foundation

struct ProductView: IProductDisplayable, Codable {
    let id: UInt
    let name: String
    let category: CategoryView
    let description: String
    let price: Double
    let imageURL: String
    var dough: [ProductOption]?
    var size: [ProductOption]?
    var additive: [ProductAdditiveView]?
}

extension ProductView {
    func toProductCart() -> ProductCart {
        return ProductCart(
            productId: self.id,
            cartItemId: UUID(),
            name: self.name,
            description: self.description,
            price: self.price,
            imageURL: self.imageURL,
            dough: self.dough,
            size: self.size,
            additive: self.additive,
            quantity: 1
        )
    }
}

struct ProductOption: Codable, Equatable, Hashable {
    let option: String
    var isSelected: Bool
    let price: Double
}

struct ProductAdditiveView: Equatable, Codable, Hashable {
    let name: String
    let price: Double
    let imageURL: String
    var isSelected: Bool
}
