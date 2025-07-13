//
//  CategoryLoader.swift
//  dodo-pizza-project-final
//
//  Created by Zakhar on 29.06.25.
//

import Foundation

protocol ICategoriesLoader {
    func loadCategories(completion: @escaping (Result<[CategoryResponse], NetworkError>) -> ())
}

final class CategoriesLoader: ICategoriesLoader {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func loadCategories(completion: @escaping (Result<[CategoryResponse], NetworkError>) -> ()) {
        let host = NetworkConstants.MokServer
        let path = APIEndpoint.categories.path
        
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
                let categories = try self.decoder.decode([CategoryResponse].self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(categories))
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError(error)))
                }
            }
            
        }
        task.resume()
    }
}
