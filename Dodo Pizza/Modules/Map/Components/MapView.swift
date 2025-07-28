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

    private var restaurants: [Address] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func centerMap(on coordinate: CLLocationCoordinate2D, radius: CLLocationDistance = 500) {
        let region = MKCoordinateRegion(
            center: coordinate,
            latitudinalMeters: radius,
            longitudinalMeters: radius
        )
        setRegion(region, animated: true)
    }
    
    func addAnnotation(at coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        annotation.subtitle = subtitle
        addAnnotation(annotation)
    }
    
    func clearAnnotations() {
        removeAnnotations(annotations)
    }
}

extension MapView {
    func setupMap(restaurants: [Address]) {
        self.restaurants = restaurants
        addRestaurantAnnotations()
    }
}

extension MapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is RestaurantAnnotation else { return nil }

        let identifier = "Pin"
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        if view == nil {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
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
    func addRestaurantAnnotations() {
        // Сначала удаляем предыдущие аннотации
        self.removeAnnotations(self.annotations)

        for address in self.restaurants {
            guard let _ = address.coordinate else { continue } // Только с координатами
            let annotation = RestaurantAnnotation(address: address)
            addAnnotation(annotation)
        }
    }
}
