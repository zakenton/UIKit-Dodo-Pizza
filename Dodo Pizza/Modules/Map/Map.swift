//
//  Map.swift
//  ViewBuilderPlayground
//
//  Created by Zakhar on 17.07.25.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

final class MapView: MKMapView {
    
    private var restorans: [Restoran] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MapView {
    func setupMap(restaurants: [Restoran]) {
        self.restorans = restaurants
        addRestaurantAnntations()
    }
    
    
}

extension MapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        guard annotation is RestaurantAnnatation else {return nil}
        
        let indentifier = "Pin"
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: indentifier) as? MKMarkerAnnotationView
        if view == nil {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: indentifier)
            view?.canShowCallout = true
            view?.markerTintColor = .orange
            view?.animatesWhenAdded = true
        } else {
            view?.annotation = annotation
        }
        return view
    }
}

private extension MapView {
    
    func addRestaurantAnntations() {
        for restoran in self.restorans {
            let annatation = RestaurantAnnatation(restoran: restoran)
            addAnnotation(annatation)
        }
    }
}
