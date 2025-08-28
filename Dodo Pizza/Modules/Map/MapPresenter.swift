//
//  MapPresenter.swift
//  Dodo Pizza
//
//  Created by Zakhar on 26.08.25.
//

import CoreLocation

protocol IMapPresenterInput: AnyObject {
    func viewDidLoad()
    func didSelectRestoran(address: Address)
    func searchAddress(query: String)
}

final class MapPresenter {
    weak var view: IMapVCInput?
    
    private var interactor: IMapInteractorInput
    
    init(interactor: IMapInteractorInput) {
        self.interactor = interactor
    }
}

extension MapPresenter: IMapPresenterInput {
    func searchAddress(query: String) {
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        interactor.geocode(query)
    }
    
    func viewDidLoad() {
        interactor.getRestorans()
    }
    
    func didSelectRestoran(address: Address) {
        
    }
}

extension MapPresenter: IMapInteractorOutput {
    func didLoad(addresses: [Address]) {
        view?.fetchRestorans(address: addresses)
    }
    
    func didFail(_ error: any Error) {
        
    }
    
    func didGeocode(query: String, coordinate: CLLocationCoordinate2D, city: String?) {
        view?.showUserPin(at: coordinate, title: query, subtitle: city)
    }
    func didFailGeocode(_ error: Error) {
        print("Geocode error:", error.localizedDescription)
    }
    
}

private extension MapPresenter {
    
}

