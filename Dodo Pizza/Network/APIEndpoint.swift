//
//  RequestBuilder.swift
//  dodo-base
//
//  Created by Zakhar on 28.06.25.
//

import Foundation

enum APIEndpoint {
    case products
    case banners
    case categories
    
    var path: String {
        switch self {
        case .products:
            return "/products"
        case .banners:
            return "/banners"
        case .categories:
            return "/categories"
        }
    }
}
