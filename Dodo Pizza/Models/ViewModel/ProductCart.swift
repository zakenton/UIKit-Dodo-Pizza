//
//  CartItem.swift
//  Dodo Pizza
//
//  Created by Zakhar on 06.07.25.
//

import Foundation

struct ProductCart: IProductDisplayable, Codable {
    let productId: UInt
    let cartItemId: UUID
    let name: String
    let description: String
    let price: Double
    let imageURL: String
    var dough: [ProductOption]?
    var size: [ProductOption]?
    var additive: [ProductAdditiveView]?
    var quantiti: UInt
}

