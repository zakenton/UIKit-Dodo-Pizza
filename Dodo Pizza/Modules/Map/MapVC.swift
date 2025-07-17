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
    
    private let mapView: MKMapView = {
        let map = MKMapView()
        
        
        
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.backgroundColor = .white
    }
    
    func setupConstraints() {
        
    }
}
