//
//  MapVC.swift
//  dodo-pizza-work
//
//  Created by Zakhar on 29.06.25.
//

import Foundation
import UIKit
import MapKit

class MapVC: UIViewController {
    
    lazy var mapView = MapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addViews()
        setupConstraints()
        
        mapView.setupMap(restaurants: StoreService.fetchStores())
    }
}

// MARK: Setup
private extension MapVC {
    func setupViews() {
        view.backgroundColor = .white
    }
    
    func addViews() {
        view.addSubview(mapView)
    }
    
    func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
