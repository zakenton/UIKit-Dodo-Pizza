//
//  AddressLoader.swift
//  Dodo Pizza
//
//  Created by Zakhar on 27.08.25.
//

import Foundation
import CoreLocation

protocol IAddressLoaderService {
    func getAddresses(completion: @escaping ([Address]) -> ())
}

final class AddressLoaderService {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
}

// MARK: - IAddressLoaderService
extension AddressLoaderService: IAddressLoaderService {
    func getAddresses(completion: @escaping ([Address]) -> ()) {
        loadAddresses { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let dtos):
                    let mapped: [Address] = dtos.map { $0.toDomain() }
                    completion(mapped)
                case .failure(let error):
                    print("Error loading addresses: \(error)")
                    completion([])
                }
            }
        }
    }
}

// MARK: - Private
private extension AddressLoaderService {
    func loadAddresses(completion: @escaping (Result<[AddressResponse], NetworkError>) -> ()) {
        let host = NetworkConstants.MokServer
        let path = APIEndpoint.address.path
        
        guard let url = URL(string: host + path) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            if let error { return completion(.failure(.network(error))) }
            guard let http = response as? HTTPURLResponse else {
                return completion(.failure(.unknown))
            }
            print("Address status code:", http.statusCode)
            guard let data else { return completion(.failure(.noData)) }
            
            do {
                let items = try self.decoder.decode([AddressResponse].self, from: data)
                completion(.success(items))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }
}

