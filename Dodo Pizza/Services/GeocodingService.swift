//
//  GeocodingService.swift
//  Dodo Pizza
//
//  Created by Zakhar on 27.08.25.
//

import Foundation
import CoreLocation

// MARK: - Models

struct GeocodeResult {
    let query: String
    let coordinate: CLLocationCoordinate2D
    let city: String?
    let postalCode: String?
}

enum GeocodingError: Error {
    case emptyQuery
    case noResult
    case network(Error)
    case failed(Error)
}

// MARK: - Protocol
protocol IGeocodingService {
    func geocode(query: String, completion: @escaping (Result<GeocodeResult, GeocodingError>) -> Void)
    func batchGeocode(addresses: [Address],
                      success: @escaping ([Address]) -> Void,
                      failure: @escaping (Error) -> Void)
}

// MARK: - Service

final class GeocodingService: IGeocodingService {
    private let geocoder = CLGeocoder()
    private let queue = DispatchQueue(label: "geocoding.serial.queue")
    private let throttleInterval: TimeInterval
    private var lastRequestAt: Date?
    private let cache: GeocodeCache

    init(throttleInterval: TimeInterval = 0.35, cacheTTL: TimeInterval = 60*60*24*30) {
        self.throttleInterval = throttleInterval
        self.cache = GeocodeCache(ttl: cacheTTL)
    }

    // MARK: Single

    func geocode(query: String, completion: @escaping (Result<GeocodeResult, GeocodingError>) -> Void) {
        let key = Self.normalize(query)
        guard !key.isEmpty else { completion(.failure(.emptyQuery)); return }

        if let cached = cache.get(key: key) {
            completion(.success(cached))
            return
        }

        // Троттлинг: один запрос раз в throttleInterval
        queue.async { [weak self] in
            guard let self else { return }
            let now = Date()
            let delta = now.timeIntervalSince(self.lastRequestAt ?? .distantPast)
            let delay = max(0, self.throttleInterval - delta)
            self.lastRequestAt = now.addingTimeInterval(delay)

            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
                guard let self else { return }
                self.geocoder.geocodeAddressString(query) { placemarks, error in
                    if let error = error {
                        if let clErr = error as? CLError, clErr.code == .network {
                            completion(.failure(.network(error)))
                        } else {
                            completion(.failure(.failed(error)))
                        }
                        return
                    }

                    guard let pm = placemarks?.first, let loc = pm.location else {
                        completion(.failure(.noResult))
                        return
                    }

                    let city  = pm.locality ?? pm.subLocality ?? pm.administrativeArea
                    let zip   = pm.postalCode
                    let result = GeocodeResult(query: key, coordinate: loc.coordinate, city: city, postalCode: zip)
                    self.cache.set(key: key, result: result)
                    completion(.success(result))
                }
            }
        }
    }

    // MARK: Batch (догеокодинг Address без координат)

    func batchGeocode(addresses: [Address],
                      success: @escaping ([Address]) -> Void,
                      failure: @escaping (Error) -> Void) {
        guard !addresses.isEmpty else { success([]); return }

        var output: [Address] = []
        var lastError: Error?

        func fullQuery(for a: Address) -> String {
            "\(a.address), \(a.zipcode) \(a.city)"
        }

        func step(_ index: Int) {
            if index >= addresses.count {
                DispatchQueue.main.async {
                    if let err = lastError { failure(err) } else { success(output) }
                }
                return
            }

            let item = addresses[index]
            if let _ = item.coordinate {
                output.append(item)
                step(index + 1)
                return
            }

            let query = fullQuery(for: item)
            geocode(query: query) { [weak self] res in
                guard let _ = self else { return }
                switch res {
                case .success(let r):
                    let updated = Address(
                        id: item.id,
                        label: item.label,
                        address: item.address,
                        zipcode: item.zipcode,
                        city: item.city,
                        coordinate: r.coordinate
                    )
                    output.append(updated)
                case .failure(let err):
                    lastError = err
                    // Добавляем как есть, чтобы не терять элемент
                    output.append(item)
                }
                step(index + 1)
            }
        }

        step(0)
    }

    // MARK: Utils

    private static func normalize(_ query: String) -> String {
        query
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
    }
}

// MARK: - Cache

final class GeocodeCache {
    private let ud = UserDefaults.standard
    private let prefix = "geo_cache_v2_"
    private let ttl: TimeInterval

    init(ttl: TimeInterval) {
        self.ttl = ttl
    }

    func get(key: String) -> GeocodeResult? {
        guard let dict = ud.dictionary(forKey: prefix + key) else { return nil }
        guard let ts = dict["ts"] as? TimeInterval else { return nil }
        guard Date().timeIntervalSince1970 - ts <= ttl else {
            ud.removeObject(forKey: prefix + key)
            return nil
        }
        guard
            let lat = dict["lat"] as? Double,
            let lon = dict["lon"] as? Double
        else { return nil }

        let city = dict["city"] as? String
        let coord = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        return GeocodeResult(query: key, coordinate: coord, city: city, postalCode: nil)
    }

    func set(key: String, result: GeocodeResult) {
        let payload: [String: Any] = [
            "lat": result.coordinate.latitude,
            "lon": result.coordinate.longitude,
            "city": result.city as Any,
            "ts": Date().timeIntervalSince1970
        ]
        ud.set(payload, forKey: prefix + key)
    }
}
