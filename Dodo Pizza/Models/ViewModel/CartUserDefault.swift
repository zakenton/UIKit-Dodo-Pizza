//
//  CartUserDefault.swift
//  Dodo Pizza
//
//  Created by Zakhar on 07.07.25.
//

import Foundation

struct CartUserDefault: Equatable, Codable {
    let id: UInt
    let dough: [String]?
    let optins: [String]?
    let additives: [String]?
    var quantity: UInt
}
