//
//  BannerLoader.swift
//  dodo-pizza-project-final
//
//  Created by Zakhar on 29.06.25.
//

import Foundation

protocol IBannersLoader {
    func loadBanners(completion: @escaping (Result<[ProductResponse], NetworkError>) -> ())
}

final class BannersLoader: IBannersLoader {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = URLSession.shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func loadBanners(completion: @escaping (Result<[ProductResponse], NetworkError>) -> ()) {
        let host = NetworkConstants.MokServer
        let path = APIEndpoint.banners.path
        
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
            } catch let error {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        task.resume()
    }
}
