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

protocol AddressInputViewDelegate: AnyObject {
    func addressInputDidChange(_ text: String)
    func addressInputDidSubmit(_ text: String)
}

final class BottomSheetView: UIView, UITextFieldDelegate {
    var onConfirmTap: (() -> Void)?
    weak var addressDelegate: AddressInputViewDelegate?
    
    private var addressText: String? { deliveryView.addressTextField.text }
    private var restorantAddress: [Address] = []
    private var userAddress: [Address] = []
    
    
    // MARK: UI Elements
    let deliveryView = DeliveryView()
    let orderView = OrderView()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        orderView.setupTable(with: restorantAddress)
        setupView()
        deliveryView.saveAddressButton.addTarget(self,
                                                 action: #selector(confirmTapped),
                                                 for: .touchUpInside)
        bindAddressInput()
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
        deliveryView.setSavedAddresses(user)
    }
    
    func fetchAdresses(restorant: [Address]) {
        self.restorantAddress = restorant
        orderView.setupTable(with: restorant)
    }
    
    func setAddressText(_ text: String?) {
        deliveryView.addressTextField.text = text
    }
    
    func bindAddressInput() {
        deliveryView.addressTextField.delegate = self
        deliveryView.addressTextField.addTarget(self, action: #selector(textChanged(_:)), for: .editingChanged)
    }
}

//MARK: Button Action
private extension BottomSheetView {
    @objc private func textChanged(_ tf: UITextField) {
        addressDelegate?.addressInputDidChange(tf.text ?? "")
    }
    
    @objc private func confirmTapped() { onConfirmTap?() }
}

//MARK: View Configurations
private extension BottomSheetView {
    func showDeliveryView() {
        deliveryView.isHidden = false
        setHeight(multiplier: 0.40)
        orderView.isHidden = true
    }
    
    func showOrderView() {
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
}

// MARK: - SetupViews
private extension BottomSheetView {
    
    
    //MARK: setup View
    func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 15
        clipsToBounds = true
        
        addViews()
        setupConstraints()
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
