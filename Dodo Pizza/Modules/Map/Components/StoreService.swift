//
//  StoreService.swift
//  ViewBuilderPlayground
//
//  Created by Zakhar on 17.07.25.
//

import Foundation
import MapKit

struct Restoran {
    let id: Int
    let name: String
    let coordinate: CLLocationCoordinate2D
    let address: Address
}

final class RestaurantAnnatation: NSObject, MKAnnotation {
    
    let restoran: Restoran
    
    var coordinate: CLLocationCoordinate2D {
        restoran.coordinate
    }
    
    var title: String? {
        restoran.name
    }
    
    var subtitle: String? {
        let address = restoran.address.address
        let code = restoran.address.zipcode
        let city = restoran.address.city
        return "\(address), \(code) \(city)"
    }
    
    init(restoran: Restoran) {
        self.restoran = restoran
    }
}

struct Address {
    let address: String
    let zipcode: String
    let city: String
}

final class StoreService {
    static func fetchStores() -> [Restoran] {
        return [
            Restoran(id: 001,
                     name: "Dodo Stadtmitte",
                     coordinate: CLLocationCoordinate2D(latitude: 48.7749375,
                                                        longitude: 9.1717924),
                     address: Address(address: "Rotebühlpl. 18", zipcode: "70173", city: "Stuttgart")),
            Restoran(id: 002,
                     name: "Dodo Tor",
                     coordinate: CLLocationCoordinate2D(latitude: 49.0058595,
                                                        longitude: 8.1610961),
                     address: Address(address: "Karl-Friedrich-Straße 26", zipcode: "76133", city: "Karlsruhe")),
            Restoran(id: 003,
                     name: "Dodo Hauptwache",
                     coordinate: CLLocationCoordinate2D(latitude: 50.1136111,
                                                        longitude: 8.6786432),
                     address: Address(address: "An der Hauptwache 15", zipcode: "60313", city: "Frankfurt am Main")),
            Restoran(id: 004,
                     name: "Dodo Marienplaz",
                     coordinate: CLLocationCoordinate2D(latitude: 48.1378085,
                                                        longitude: 11.5759977),
                     address: Address(address: "Marienplatz 8", zipcode: "80333", city: "Marienplatz 8, 80333 München")),
        ]
    }
}
