//
//  ProductsLoader.swift
//  dodo-pizza-project-final
//
//  Created by Zakhar on 28.06.25.
//

import Foundation

protocol IProductsLoader {
    func loadProducts(completion: @escaping (Result<[ProductResponse], NetworkError>) -> ())
}

final class ProductsLoader: IProductsLoader {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func loadProducts(completion: @escaping (Result<[ProductResponse], NetworkError>) -> ()) {
        let host = NetworkConstants.MokServer
        let path = APIEndpoint.products.path
        
        guard let url = URL(string: host + path) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(.network(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.unknown))
                return
            }
            print(httpResponse.statusCode)
            
            
            
            guard let data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let products = try self.decoder.decode([ProductResponse].self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(products))
                }
            } catch let DecodingError.dataCorrupted(context) {
                print("Data corrupted: \(context)")
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found: \(context.debugDescription)")
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found: \(context.debugDescription)")
            } catch let DecodingError.typeMismatch(type, context) {
                print("Type mismatch for type '\(type)': \(context.debugDescription), path: \(context.codingPath)")
            } catch {
                print("Error: \(error)")
            }
        }
        task.resume()
    }
}
