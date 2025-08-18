//
//  MapVC.swift
//  dodo-pizza-work
//
//  Created by Zakhar on 29.06.25.
//

import UIKit
import MapKit

class MapVC: UIViewController {
    
    private lazy var selectOptions = SelectorView()
    lazy var mapView = MapView()
    lazy var bottomSheet = BottomSheetView()
    
    private var searchTimer: Timer?
    private let searchDelay: TimeInterval = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        addViews()
        setupConstraints()
        
        selectOptions.addTarget(self, action: #selector(selectionChanged), for: .valueChanged)
        bottomSheet.configure(for: .delivery)
    }
}

// MARK: Private
private extension MapVC {
    
    @objc private func selectionChanged(_ sender: SelectorView) {
        if sender.selectedIndex == 0 {
            bottomSheet.configure(for: .delivery)
        } else {
            bottomSheet.configure(for: .order)
        }
    }
    
    @objc private func addressTextChanged(_ textField: UITextField) {
        searchTimer?.invalidate()
        
        searchTimer = Timer.scheduledTimer(
            timeInterval: searchDelay,
            target: self,
            selector: #selector(performAddressSearch),
            userInfo: nil,
            repeats: false
        )
    }
    
    @objc private func performAddressSearch() {
        guard let address = bottomSheet.deliveryView.addressTextField.text, !address.isEmpty else { return }
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Ошибка геокодирования: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first, let location = placemark.location {
                mapView.centerMap(on: location.coordinate)
                
                mapView.addAnnotation(
                    at: location.coordinate,
                    title: address,
                    subtitle: placemark.locality
                )
            }
        }
    }
}

// MARK: Setup
private extension MapVC {
    func setupViews() {
        view.backgroundColor = .white
        mapView.setupMap(restaurants: StoreService.fetchStores())
        bottomSheet.fetchAdresses(restorant: StoreService.fetchStores())
        setupAddressTextField()
    }
    
    func addViews() {
        view.addSubview(mapView)
        view.addSubview(selectOptions)
        view.addSubview(bottomSheet)
    }
    
    private func setupAddressTextField() {
        bottomSheet.deliveryView.addressTextField.delegate = self
        bottomSheet.deliveryView.addressTextField.addTarget(
            self,
            action: #selector(addressTextChanged(_:)),
            for: .editingChanged
        )
    }
    
    func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        selectOptions.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Layout.offset8)
            make.left.equalToSuperview().inset(30)
            make.right.equalToSuperview().inset(30)
            make.height.equalTo(40)
        }
        
        bottomSheet.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.40)
        }
    }
}

// MARK: - UITextFieldDelegate
extension MapVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        performAddressSearch()
        return true
    }
}
