//
//  AddressViewModel.swift
//  Dodo Pizza
//
//  Created by Zakhar on 21.07.25.
//

import Foundation
import MapKit

struct Address {
    let id: Int?
    let label: Mark
    let address: String
    let zipcode: String
    let city: String
    let coordinate: CLLocationCoordinate2D?
}

struct AddressCandidate {
    let address: String
    let zipcode: String
    let city: String
    let coordinate: CLLocationCoordinate2D
}


enum Mark: String {
    case home = "Home"
    case work = "Work"
    case restaurant = "Restaurant"
    case custom = "Custom"
}

final class RestaurantAnnotation: NSObject, MKAnnotation {
    let address: Address

    var coordinate: CLLocationCoordinate2D {
        address.coordinate ?? CLLocationCoordinate2D()
    }
    
    var title: String? {
        address.label.rawValue // ← сначала Mark (например "Home", "Work")
    }
    
    var subtitle: String? {
        "\(address.address), \(address.zipcode) \(address.city)"
    }

    init(address: Address) {
        self.address = address
    }
}
