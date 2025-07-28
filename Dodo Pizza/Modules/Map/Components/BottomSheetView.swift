//
//  FindAdressView.swift
//  Dodo Pizza
//
//  Created by Zakhar on 19.07.25.
//

import Foundation
import UIKit
import SnapKit

enum SheetType: String, Equatable {
    case delivery = "Delivery"
    case order = "Order"
}

final class BottomSheetView: UIView {
    
    var userAddress: [Address] = []
    var restorantAddress: [Address] = []
    
    
    // MARK: UI Elements
    let deliveryView = DeliveryView()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - PUBLIC API

extension BottomSheetView {
    func configure(for type: SheetType) {
        switch type {
        case .delivery:
            showDeliveryView()
        case .order:
            showOrderView()
        }
    }
}

//MARK: Button Action
private extension BottomSheetView {
    
}

// MARK: - PRIVATE
private extension BottomSheetView {
    
    func showDeliveryView() {
        // Показываем только форму адреса
        deliveryView.isHidden = false
        setHeight(multiplier: 0.40)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.deliveryView.addressTextField.becomeFirstResponder()
        }
    }
    
    func showOrderView() {
        // Показываем только список ресторанов
        deliveryView.isHidden = true
        setHeight(multiplier: 0.30)
    }
    
    func setHeight(multiplier: CGFloat) {
        guard let superview = superview else { return }
        self.snp.remakeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(superview.snp.height).multipliedBy(multiplier)
        }
        UIView.animate(withDuration: 0.3) {
            superview.layoutIfNeeded()
        }
    }
    //MARK: setup View
    func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 15
        clipsToBounds = true
    }
    
    //MARK: add Views
    func addViews() {
        addSubview(deliveryView)
    }
    
    // MARK: Constraints
    func setupConstraints() {
        deliveryView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


//MARK: TableView DataSourse

//extension BottomSheetView: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        restorantAddress.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//}
