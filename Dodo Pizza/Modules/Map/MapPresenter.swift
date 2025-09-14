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
    func confirmCurrentAddress()
    func saveConfirmedAddress(with mark: Mark)
}

final class MapPresenter {
    weak var view: IMapVCInput?
    
    private var interactor: IMapInteractorInput
    
    private var lastGeocode: GeocodeResult?
    private var lastRawText: String?
    
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
    
    func confirmCurrentAddress() {
        guard let geo = lastGeocode else {
            view?.showMessage("Сначала выберите адрес на карте.")
            return
        }
        // Собираем кандидата из геокода и последнего текста
        let candidate = AddressCandidate(
            address: lastRawText ?? geo.query,
            zipcode: geo.postalCode ?? "",
            city: geo.city ?? "",
            coordinate: geo.coordinate
        )
        interactor.confirmAddressSelection(candidate: candidate)
    }
    
    func saveConfirmedAddress(with mark: Mark) {
        // Защитимся от запрета "кроме restaurant"
        let chosen = (mark == .restaurant) ? .custom : mark
        guard let geo = lastGeocode else { return }
        let candidate = AddressCandidate(
            address: lastRawText ?? geo.query,
            zipcode: geo.postalCode ?? "",
            city: geo.city ?? "",
            coordinate: geo.coordinate
        )
        interactor.saveAddress(candidate: candidate, mark: chosen)
    }
}

extension MapPresenter: IMapInteractorOutput {
    func didLoad(addresses: [Address]) {
        view?.fetchRestorans(address: addresses)
    }
    
    func didFail(_ error: any Error) {
        view?.showMessage("Ошибка: \(error.localizedDescription)")
    }
    
    func didGeocode(query: String, coordinate: CLLocationCoordinate2D, city: String?) {
        rememberGeocode(query: query, coordinate: coordinate, city: city)
        view?.showUserPin(at: coordinate, title: lastRawText ?? query, subtitle: city)
    }
    
    func didFailGeocode(_ error: Error) {
        print("Geocode error:", error.localizedDescription)
    }
    
    func addressAlreadyExists(_ address: Address) {
        view?.showMessage("Этот адрес уже сохранён.")
        view?.fetchUserAddress(address: [address]) // по желанию обновить список
    }
    
    func needUserToConfirmSave(candidate: AddressCandidate) {
        // Предлагаем сохранить и попросим выбрать Mark (без restaurant)
        view?.promptSaveAddress(availableMarks: [.home, .work, .custom])
    }
    
    func didSaveAddress(_ address: Address) {
        view?.showMessage("Адрес сохранён.")
        view?.fetchUserAddress(address: [address])
    }
}

private extension MapPresenter {
    private func rememberGeocode(query: String,
                                 coordinate: CLLocationCoordinate2D,
                                 city: String?,
                                 postalCode: String? = nil) {
        lastGeocode = GeocodeResult(query: query, coordinate: coordinate, city: city, postalCode: postalCode)
        if (lastRawText?.isEmpty ?? true) { lastRawText = query }
    }
}

