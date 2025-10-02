import Foundation
import CoreLocation

protocol IUserAddressStore {
    func list() -> [Address]
    func exists(candidate: AddressCandidate, epsilonMeters: CLLocationDistance) -> Address?
    @discardableResult
    func save(_ address: Address) throws -> Address
}

enum AddressStoreError: Error {
    case encodeFailed
    case decodeFailed
}

final class UserAddressStore: IUserAddressStore {
    private let key = "user_addresses_v1"
    private let ud = UserDefaults.standard
    
    
    private struct AddressDTO: Codable {
        let id: Int
        let label: String
        let address: String
        let zipcode: String
        let city: String
        let latitude: Double
        let longitude: Double
        
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
        
        static func fromDomain(_ a: Address) -> AddressDTO? {
            guard let c = a.coordinate else { return nil }
            return AddressDTO(
                id: a.id ?? -1,
                label: a.label.rawValue,
                address: a.address,
                zipcode: a.zipcode,
                city: a.city,
                latitude: c.latitude,
                longitude: c.longitude
            )
        }
    }
    
    func list() -> [Address] {
        guard let data = ud.data(forKey: key) else { return [] }
        do {
            let dtos = try JSONDecoder().decode([AddressDTO].self, from: data)
            return dtos.map { $0.toDomain() }
        } catch {
            return []
        }
    }
    
    private func persist(_ items: [Address]) throws {
        let dtos: [AddressDTO] = items.compactMap { AddressDTO.fromDomain($0) }
        do {
            let data = try JSONEncoder().encode(dtos)
            ud.set(data, forKey: key)
        } catch {
            throw AddressStoreError.encodeFailed
        }
    }
    
    func exists(candidate: AddressCandidate, epsilonMeters: CLLocationDistance = 30) -> Address? {
        let all = list()
        
        let normCandidate = normalize("\(candidate.address), \(candidate.zipcode) \(candidate.city)")
        
        for a in all {
            let normStored = normalize("\(a.address), \(a.zipcode) \(a.city)")
            if normStored == normCandidate { return a }
            if let c = a.coordinate {
                let dist = distanceMeters(c, candidate.coordinate)
                if dist < epsilonMeters { return a }
            }
        }
        return nil
    }
    
    @discardableResult
    func save(_ address: Address) throws -> Address {
        var all = list()
        
        let nextID = (all.compactMap { $0.id }.max() ?? 0) + 1
        let toInsert = Address(
            id: address.id ?? nextID,
            label: address.label,
            address: address.address,
            zipcode: address.zipcode,
            city: address.city,
            coordinate: address.coordinate
        )
        all.append(toInsert)
        try persist(all)
        return toInsert
    }
    
    // Helpers
    private func normalize(_ s: String) -> String {
        s.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    }
    private func distanceMeters(_ a: CLLocationCoordinate2D, _ b: CLLocationCoordinate2D) -> CLLocationDistance {
        let la = CLLocation(latitude: a.latitude, longitude: a.longitude)
        let lb = CLLocation(latitude: b.latitude, longitude: b.longitude)
        return la.distance(from: lb)
    }
}
