//
//  RequestBuilder.swift
//  dodo-base
//
//  Created by Zakhar on 28.06.25.
//

import Foundation

enum APIEndpoint {
    case products(category: String?)
    case banners
    case categories
    
    var path: String {
        switch self {
        case .products(let category):
            var components = URLComponents(string: "/products")
            if let category = category {
                components?.queryItems = [URLQueryItem(name: "category", value: category.lowercased())]
            }
            return components?.string ?? "/products"
        case .banners:
            return "/banners"
        case .categories:
            return "/categories"
        }
    }
}
