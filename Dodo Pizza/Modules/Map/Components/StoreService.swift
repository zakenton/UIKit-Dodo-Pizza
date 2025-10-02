import Foundation
import MapKit


final class StoreService {
    static func fetchStores() -> [Address] {
        return [
            Address(
                id: 1,
                label: .restaurant,
                address: "Rotebühlpl. 18",
                zipcode: "70173",
                city: "Stuttgart",
                coordinate: CLLocationCoordinate2D(latitude: 48.7749375, longitude: 9.1717924)
            ),
            Address(
                id: 2,
                label: .restaurant,
                address: "Karl-Friedrich-Straße 26",
                zipcode: "76133",
                city: "Karlsruhe",
                coordinate: CLLocationCoordinate2D(latitude: 49.0058595, longitude: 8.1610961)
            ),
            Address(
                id: 3,
                label: .restaurant,
                address: "An der Hauptwache 15",
                zipcode: "60313",
                city: "Frankfurt am Main",
                coordinate: CLLocationCoordinate2D(latitude: 50.1136111, longitude: 8.6786432)
            ),
            Address(
                id: 4,
                label: .restaurant,
                address: "Marienplatz 8",
                zipcode: "80333",
                city: "München",
                coordinate: CLLocationCoordinate2D(latitude: 48.1378085, longitude: 11.5759977)
            )
        ]
    }

    static func fetchUserAddresses() -> [Address] {
        return [
            Address(
                id: nil,
                label: .home,
                address: "Goethestraße 15",
                zipcode: "80336",
                city: "München",
                coordinate: nil
            ),
            Address(
                id: nil,
                label: .work,
                address: "Rosenheimer Str. 20",
                zipcode: "81669",
                city: "München",
                coordinate: nil
            ),
            Address(
                id: nil,
                label: .custom,
                address: "Maximilianstraße 17",
                zipcode: "80539",
                city: "München",
                coordinate: nil
            )
        ]
    }
}
