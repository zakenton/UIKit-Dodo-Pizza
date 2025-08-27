//
//  MapBuilder.swift
//  Dodo Pizza
//
//  Created by Zakhar on 03.07.25.
//
import UIKit

final class MapAssembly {
    
    private let addressLoader: IAddressLoaderService
    
    init(addressLoader: IAddressLoaderService) {
        self.addressLoader = addressLoader
    }
    
    func build() -> UIViewController {
        let interactor = MapInteractor(restoransLoader: addressLoader)
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
