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
    
    private var userAddress: [Address] = []
    private var restorantAddress: [Address] = []
    
    
    // MARK: UI Elements
    let deliveryView = DeliveryView()
    let orderView = OrderView()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        orderView.setupTable(with: restorantAddress)
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
    
    func fetchAdresses(user: [Address]) {
        self.userAddress = user
    }
    
    func fetchAdresses(restorant: [Address]) {
        self.restorantAddress = restorant
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
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            self.deliveryView.addressTextField.becomeFirstResponder()
//        }
        orderView.isHidden = true
    }
    
    func showOrderView() {
        // Показываем только список ресторанов
        deliveryView.isHidden = true
        setHeight(multiplier: 0.30)
        orderView.isHidden = false
    }
    
    func setHeight(multiplier: CGFloat) {
        guard let superview = superview else { return }
        snp.remakeConstraints { make in
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
        addSubview(orderView)
    }
    
    // MARK: Constraints
    func setupConstraints() {
        deliveryView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        orderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
