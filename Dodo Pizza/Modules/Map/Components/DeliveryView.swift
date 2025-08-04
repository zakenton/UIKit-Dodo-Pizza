//
//  DeliveryView.swift
//  Dodo Pizza
//
//  Created by Zakhar on 20.07.25.
//

import UIKit
import SnapKit

final class DeliveryView: UIView {
    
    // MARK: UI Elements
    private let myAddressButton = Button(style: .savedAddress("Saved Address"))
    
    let addressTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Houpt str. 1, 98000 Berlin"
        tf.font = .systemFont(ofSize: 16)
        tf.borderStyle = .roundedRect
        tf.keyboardType = .default
        tf.isUserInteractionEnabled = true
        return tf
    }()
    
    private let saveAddressButton = Button(style: .useThisAddress("Use this Address"))
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addViews()
        setupConstraints()
        addTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Button Action
private extension DeliveryView {
    
    func addTargets() {
        myAddressButton.addTarget(self, action: #selector(didTapChangeViewButton), for: .touchUpInside)
    }
    
    @objc func didTapChangeViewButton() {
        
    }
}


//MARK: Setup View
private extension DeliveryView {
    
    func showAddressList() {
        addressTextField.isHidden = true
        saveAddressButton.isHidden = true
        myAddressButton.configuration?.attributedTitle = AttributedString("+ Add new")
    }
    
    func showAddNewAddressView() {
        addressTextField.isHidden = false
        saveAddressButton.isHidden = false
        myAddressButton.configuration?.attributedTitle = AttributedString("📍Saved Address")
    }
    
    func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 15
        clipsToBounds = true
    }
    
    //MARK: add Views
    func addViews() {
        addSubview(myAddressButton)
        addSubview(addressTextField)
        addSubview(saveAddressButton)
    }
    
    // MARK: Constraints
    func setupConstraints() {
        myAddressButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.left.equalTo(snp.centerX).inset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(32)
        }
        
        addressTextField.snp.makeConstraints { make in
            make.top.equalTo(myAddressButton.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        saveAddressButton.snp.makeConstraints { make in
            make.top.equalTo(addressTextField.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}
