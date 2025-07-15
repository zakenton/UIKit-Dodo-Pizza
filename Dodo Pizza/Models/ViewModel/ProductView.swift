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
    func toCartUserDefaults() -> CartUserDefault {
        /// only selected!
        let selectedDough = dough?
            .filter { $0.isSelected }
            .map { $0.option }
        
        let selectedOptions = size?
            .filter { $0.isSelected }
            .map { $0.option }
        
        let selectedAdditives = additive?
            .filter { $0.isSelected }
            .map { $0.name }
        
        
        return CartUserDefault(productId: id,
                               cartItemId: UUID(),
                               dough: selectedDough,
                               optins: selectedOptions,
                               additives: selectedAdditives,
                               quantity: 1)
    }
}

struct ProductOption: Codable, Equatable, Hashable {
    let option: String
    var isSelected: Bool
    let price: Double
}

struct ProductAdditiveView: Equatable, Codable {
    let name: String
    let price: Double
    let imageURL: String
    var isSelected: Bool
}
