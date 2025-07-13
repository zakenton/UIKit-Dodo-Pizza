//
//  CartItem.swift
//  Dodo Pizza
//
//  Created by Zakhar on 06.07.25.
//

import Foundation

struct ProductCart: Codable {
    let product: ProductView
    let selectedDough: ProductOption?
    let selectedOptions: [ProductOption]?
    let selectedAdditiveOptions: [ProductOption]?
    var quantity: Int
    
    var totalPrice: Double {
        let basePrice = product.price
        let doughPrice = selectedDough?.price ?? 0
        let optionsPrice = selectedOptions?.reduce(0) { $0 + $1.price } ?? 0
        let addedOptionsPrice = selectedAdditiveOptions?.reduce(0) { $0 + $1.price } ?? 0
        
        return (basePrice + doughPrice + optionsPrice + addedOptionsPrice) * Double(quantity)
    }
    
    var optionsDescription: String {
        var parts = [String]()
        
        if let dough = selectedDough {
            parts.append("Dough: \(dough.option)")
        }
        
        if let options = selectedOptions {
            parts.append(contentsOf: options.map { $0.option })
        }
        
        if let addedOptions = selectedAdditiveOptions {
            parts.append(contentsOf: addedOptions.map { "+ \($0.option)" })
        }
        
        return parts.joined(separator: ", ")
    }
}
