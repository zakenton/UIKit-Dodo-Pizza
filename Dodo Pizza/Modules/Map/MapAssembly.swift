//
//  MapBuilder.swift
//  Dodo Pizza
//
//  Created by Zakhar on 03.07.25.
//
import UIKit

final class MapAssembly {
    
    init() {
        
    }
    
    func build() -> UIViewController {
        let mapVC = MapVC()
        mapVC.tabBarItem = UITabBarItem(title: "Map",
                                        image: UIImage(systemName: "location"),
                                        selectedImage: UIImage(systemName: "location"))
        
        return mapVC
    }
}
