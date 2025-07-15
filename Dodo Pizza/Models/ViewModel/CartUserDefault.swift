//
//  CartUserDefault.swift
//  Dodo Pizza
//
//  Created by Zakhar on 07.07.25.
//

import Foundation

struct CartUserDefault: Equatable, Codable {
    let productId: UInt
    let cartItemId: UUID
    let dough: [String]?
    let optins: [String]?
    let additives: [String]?
    var quantity: UInt
}
