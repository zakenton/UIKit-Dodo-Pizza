//
//  ProductsLoader.swift
//  dodo-pizza-project-final
//
//  Created by Zakhar on 28.06.25.
//

import Foundation

protocol ILoaderService {
    func getProducts(by category: CategoryView, completion: @escaping ([ProductView]) -> ())
    func getBanners(completion: @escaping ([ProductView]) -> ())
    func getCategories(completion: @escaping ([CategoryView]) -> ())
}

final class LoaderService {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
}
// MARK: - ILoaderService
extension LoaderService: ILoaderService {
    func getProducts(by category: CategoryView, completion: @escaping ([ProductView]) -> ()) {
        let path = APIEndpoint.products(category: category.rawValue).path
        print("Requesting products from path: \(path)")
        
        loadProducts(by: path) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    let mapped = products.compactMap { $0.toProductView() }
                    completion(mapped)
                case .failure(let error):
                    print("Error loading products: \(error)")
                    completion([])
                }
            }
        }
    }
    
    func getBanners(completion: @escaping ([ProductView]) -> ()) {
        loadBanners { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    let mapped = products.compactMap { $0.toProductView() }
                    completion(mapped)
                case .failure(let error):
                    print("Error loading banners: \(error)")
                    completion([])
                }
            }
        }
    }
    
    func getCategories(completion: @escaping ([CategoryView]) -> ()) {
        loadCategories { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let categories):
                    let mapped = categories.compactMap { $0.toCategoryMenu() }
                    completion(mapped)
                case .failure(let error):
                    print("Error loading categories: \(error)")
                    completion([])
                }
            }
        }
    }
}

//MARK: - Private
private extension LoaderService {
    
    
    //MARK: loadProducts
    func loadProducts(by path: String, completion: @escaping (Result<[ProductResponse], NetworkError>) -> ()) {
        let host = NetworkConstants.MokServer

        guard let url = URL(string: host + path) else {
            completion(.failure(.invalidURL))
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

            print("Status code: \(httpResponse.statusCode)")

            guard let data else {
                completion(.failure(.noData))
                return
            }

            do {
                let products = try self.decoder.decode([ProductResponse].self, from: data)
                completion(.success(products))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(.decodingError(error)))
            }
        }

        task.resume()
    }
    //MARK: loadBanners
    func loadBanners(completion: @escaping (Result<[ProductResponse], NetworkError>) -> ()) {
        let host = NetworkConstants.MokServer
        let path = APIEndpoint.banners.path
        
        guard let url = URL(string: host + path) else {
            completion(.failure(.invalidURL))
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
                completion(.success(products))
            } catch let error {
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }
    //MARK: loadCategories
    func loadCategories(completion: @escaping (Result<[CategoryResponse], NetworkError>) -> ()) {
        let host = NetworkConstants.MokServer
        let path = APIEndpoint.categories.path
        
        guard let url = URL(string: host + path) else {
            completion(.failure(.invalidURL))
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
                completion(.success(categories))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        
        task.resume()
    }
}
