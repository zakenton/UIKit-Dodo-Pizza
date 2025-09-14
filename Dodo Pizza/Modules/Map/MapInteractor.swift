//
//  MapInteractor.swift
//  Dodo Pizza
//
//  Created by Zakhar on 26.08.25.
//

import Foundation
import CoreLocation

protocol IMapInteractorInput: AnyObject {
    func getRestorans()
    func getUserAddress()
    func geocode(_ query: String)
    func confirmAddressSelection(candidate: AddressCandidate)
    func saveAddress(candidate: AddressCandidate, mark: Mark)
}

protocol IMapInteractorOutput: AnyObject {
    func didLoad(addresses: [Address])
    func didFail(_ error: Error)
    func didGeocode(query: String,
                    coordinate: CLLocationCoordinate2D,
                    city: String?)
    func didFailGeocode(_ error: Error)
    func addressAlreadyExists(_ address: Address)
    func needUserToConfirmSave(candidate: AddressCandidate)
    func didSaveAddress(_ address: Address)
}

final class MapInteractor {
    weak var presenter: IMapInteractorOutput?
    
    private let restoransLoader: IAddressLoaderService
    private let geocoding: IGeocodingService
    private let addressStore: IUserAddressStore
    
    init(restoransLoader: IAddressLoaderService, geocoding: IGeocodingService, addressStore: IUserAddressStore) {
        self.restoransLoader = restoransLoader
        self.geocoding = geocoding
        self.addressStore = addressStore
    }
}

extension MapInteractor: IMapInteractorInput {
    func getUserAddress() {
        
    }
    
    func geocode(_ query: String) {
        geocoding.geocode(query: query) { result in
            switch result {
            case .success(let item):
                self.presenter?.didGeocode(query: query, coordinate: item.coordinate, city: item.city)
            case .failure(let err):
                self.presenter?.didFailGeocode(err)
            }
        }
    }
    
    func getRestorans() {
        restoransLoader.getAddresses { [weak self] addresses in
            guard let self else { return }
            
            // 1) Фильтруем адреса без координат или с (0,0)
            let valid = addresses.filter {
                if let c = $0.coordinate {
                    return !(c.latitude == 0 && c.longitude == 0)
                }
                return false
            }
            
            // 2) Удаляем дубликаты по id (если id может быть nil — считаем уникальным)
            let unique = Self.uniqueByID(valid)
            
            // 3) Сортируем: сначала по label, затем по city, затем по address
            let sorted = unique.sorted {
                if $0.label.rawValue != $1.label.rawValue {
                    return $0.label.rawValue < $1.label.rawValue
                }
                if $0.city != $1.city {
                    return $0.city < $1.city
                }
                return $0.address < $1.address
            }
            
            DispatchQueue.main.async {
                self.presenter?.didLoad(addresses: sorted)
            }
        }
    }
    
    private static func uniqueByID(_ items: [Address]) -> [Address] {
        var seen = Set<Int>()
        var result: [Address] = []
        for a in items {
            if let id = a.id {
                if !seen.contains(id) {
                    seen.insert(id)
                    result.append(a)
                }
            } else {
                // у кого id == nil — добавляем как уникальные
                result.append(a)
            }
        }
        return result
    }
    
    func confirmAddressSelection(candidate: AddressCandidate) {
        if let existing = addressStore.exists(candidate: candidate, epsilonMeters: 30) {
            presenter?.addressAlreadyExists(existing)
        } else {
            presenter?.needUserToConfirmSave(candidate: candidate)
        }
    }
    
    func saveAddress(candidate: AddressCandidate, mark: Mark) {
        // Safety: не даём сохранить restaurant
        let safeMark: Mark = (mark == .restaurant) ? .custom : mark
        let address = Address(
            id: nil,
            label: safeMark,
            address: candidate.address,
            zipcode: candidate.zipcode,
            city: candidate.city,
            coordinate: candidate.coordinate
        )
        do {
            let saved = try addressStore.save(address)
            presenter?.didSaveAddress(saved)
        } catch {
            presenter?.didFail(error)
        }
    }
}


private extension MapInteractor {
    
}
