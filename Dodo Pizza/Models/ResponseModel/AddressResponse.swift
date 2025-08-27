//
//  AddressResponse.swift
//  Dodo Pizza
//
//  Created by Zakhar on 27.08.25.
//

import Foundation
import CoreLocation

struct AddressResponse: Codable {
    let id: Int
    let label: String         // "Home" | "Work" | "Restaurant" | "Custom"
    let address: String
    let zipcode: String
    let city: String
    let latitude: Double
    let longitude: Double
}

// MARK: - Mapping to domain
extension AddressResponse {
    func toDomain() -> Address {
        Address(
            id: id,
            label: Mark(rawValue: label) ?? .custom,
            address: address,
            zipcode: zipcode,
            city: city,
            coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        )
    }
}
