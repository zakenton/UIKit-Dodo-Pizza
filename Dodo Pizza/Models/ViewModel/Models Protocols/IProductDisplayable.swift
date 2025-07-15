//
//  ProductDisplayable.swift
//  Dodo Pizza
//
//  Created by Zakhar on 15.07.25.
//

import Foundation

protocol IProductDisplayable {
    var name: String { get }
    var price: Double { get }
    var description: String { get }
    var imageURL: String { get }
    var dough: [ProductOption]? { get set }
    var size: [ProductOption]? { get set }
    var additive: [ProductAdditiveView]? { get set }
}
