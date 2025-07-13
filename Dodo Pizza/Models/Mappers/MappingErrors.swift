//
//  MappingErrors.swift
//  Dodo Pizza
//
//  Created by Zakhar on 09.07.25.
//

import Foundation

enum MappingError: Error, LocalizedError {
    case invalidCategory(String)
    case invalidPrice(String)
    case invalidDoughPrice(String)
    case invalidSizePrice(String)
    case invalidAdditives(String)
    
    var errorDescription: String {
        switch self {
            
        case .invalidCategory(let value):
            return "Failed to convert category: \(value)"
        case .invalidPrice(let value):
            return "Failed to convert price: \(value)"
        case .invalidDoughPrice(let value):
            return "Failed to convert dough option price: \(value)"
        case .invalidSizePrice(let value):
            return "Failed to convert size option price: \(value)"
        case .invalidAdditives(let value):
            return "Failed to convert additive prise: \(value)"
        }
    }
}
