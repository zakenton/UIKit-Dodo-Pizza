//
//  MapInteractor.swift
//  Dodo Pizza
//
//  Created by Zakhar on 26.08.25.
//

import Foundation

protocol IMapInteractorInput: AnyObject {
    func getRestorans()
}

protocol IMapInteractorOutput: AnyObject {
    func didLoad(addresses: [Address])
    func didFail(_ error: Error)
}

final class MapInteractor {
    weak var presenter: IMapInteractorOutput?
    
    private let restoransLoader: IAddressLoaderService
    
    init(restoransLoader: IAddressLoaderService) {
        self.restoransLoader = restoransLoader
    }
}

extension MapInteractor: IMapInteractorInput {
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
}


private extension MapInteractor {
    
}
