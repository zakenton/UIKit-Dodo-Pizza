//
//  MapBuilder.swift
//  Dodo Pizza
//
//  Created by Zakhar on 03.07.25.
//
import UIKit

final class MapAssembly {
    
    private let addressLoader: IAddressLoaderService
    private let geocoding: IGeocodingService
    private let addressStore: IUserAddressStore
    
    init(addressLoader: IAddressLoaderService, geocoding: IGeocodingService, addressStore: IUserAddressStore) {
        self.addressLoader = addressLoader
        self.geocoding = geocoding
        self.addressStore = addressStore
    }
    
    func build() -> UIViewController {
        let interactor = MapInteractor(restoransLoader: addressLoader, geocoding: geocoding, addressStore: addressStore)
        let presenter = MapPresenter(interactor: interactor)
        let mapVC = MapVC(presenter: presenter)
        mapVC.tabBarItem = UITabBarItem(title: "Map",
                                        image: UIImage(systemName: "location"),
                                        selectedImage: UIImage(systemName: "location"))
        presenter.view = mapVC
        interactor.presenter = presenter
        return mapVC
    }
}
