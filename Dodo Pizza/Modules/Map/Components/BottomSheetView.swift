//
//  FindAdressView.swift
//  Dodo Pizza
//
//  Created by Zakhar on 19.07.25.
//

import Foundation
import UIKit
import SnapKit

enum SheetType: String {
    case delivery = "Delivery"
    case order = "Order"
}

final class BottomSheetView: UIView {
    
    private let myAddressButton: UIButton = {
        let button = UIButton()
        
        var config = UIButton.Configuration.plain()
        
        var attributedTitle = AttributedString("📍Saved address")
        attributedTitle.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        attributedTitle.foregroundColor = .black
        
        config.attributedTitle = attributedTitle
        config.baseForegroundColor = .black
        config.baseBackgroundColor = AppColor.Button.gray
        config.cornerStyle = .capsule
        
        button.configuration = config
        
        return button
    }()
    
    private var strTextFild: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Street"
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.keyboardType = .default
        textField.textColor = .black
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private var zipCodeTextFild: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Street"
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.keyboardType = .default
        textField.textColor = .black
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private var cityTextFild: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Street"
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.keyboardType = .default
        textField.textColor = .black
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private var commentTextFild: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Street"
        textField.font = .systemFont(ofSize: 16, weight: .regular)
        textField.keyboardType = .default
        textField.textColor = .black
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        
        return textField
    }()
    
    private let saveAddres = Button(style: .addToCart, text: "Add Address")
    
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

extension BottomSheetView {
    func configure(for type: String) {
        
    }
}

private extension BottomSheetView {
    func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 15
    }
    
    func addViews() {
        addSubview(myAddressButton)
        addSubview(strTextFild)
        addSubview(zipCodeTextFild)
        addSubview(cityTextFild)
        addSubview(saveAddres)
    }
    
    func setupConstraints() {
        myAddressButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Layout.offset12)
            make.left.equalToSuperview().inset(Layout.screenWidth * 0.4)
            make.right.equalToSuperview().inset(Layout.offset8)
            make.height.equalTo(30)
        }
        
        strTextFild.snp.makeConstraints { make in
            make.top.equalTo(myAddressButton.snp.bottom).offset(Layout.offset12)
            make.left.equalToSuperview().inset(Layout.offset16)
            make.right.equalToSuperview().inset(Layout.offset16)
            make.height.equalTo(50)
        }
        
        zipCodeTextFild.snp.makeConstraints { make in
            make.top.equalTo(strTextFild.snp.bottom).offset(Layout.offset8)
            make.left.equalToSuperview().inset(Layout.offset16)
            make.right.equalTo(snp.centerX).offset(-Layout.offset6)
            make.height.equalTo(50)
        }
        
        cityTextFild.snp.makeConstraints { make in
            make.top.equalTo(strTextFild.snp.bottom).offset(Layout.offset8)
            make.left.equalTo(snp.centerX).offset(Layout.offset6)
            make.right.equalToSuperview().inset(Layout.offset16)
            make.height.equalTo(50)
        }
        
        saveAddres.snp.makeConstraints { make in
            make.top.equalTo(cityTextFild.snp.bottom).offset(Layout.offset8)
            make.left.right.equalToSuperview().inset(Layout.offset16)
            make.height.equalTo(60)
        }
        
    }
}
