//
//  NetworkError.swift
//  dodo-pizza-project-final
//
//  Created by Zakhar on 28.06.25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError(Error)
    case statusCode(Int)
    case network(Error)
    case unknown
}
