//
//  MainTabBarC.swift
//  dodo-pizza-project-final
//
//  Created by Zakhar on 29.06.25.
//

import Foundation
import UIKit
import SnapKit


final class RootTabBarController: UITabBarController {
    private let menuAssembly: MenuAssembly
    private let mapAssembly: MapAssembly
    private let cartAssembly: CartAssembly
    
    init(menuAssembly: MenuAssembly, mapAssembly: MapAssembly, cartAssembly: CartAssembly ) {
        self.menuAssembly = menuAssembly
        self.mapAssembly = mapAssembly
        self.cartAssembly = cartAssembly
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        viewControllers = [menuAssembly.build(),
                           mapAssembly.build(),
                           cartAssembly.build()]
    }
    
    
    private func setup() {
        tabBar.tintColor = .orange
        tabBar.backgroundColor = .white
    }
}
