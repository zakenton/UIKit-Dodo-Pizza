//
//  Button.swift
//  dodo-pizza-work
//
//  Created by Zakhar on 29.06.25.
//

import Foundation
import UIKit

enum ButtonStyle {
    case cross
    case price
    case addToCart
    case useThisAddress
    case savedAddress
}

final class Button: UIButton {
    
    init(style: ButtonStyle, text: String) {
        super.init(frame: .zero)
        switch style {
        case .cross:
            createCrossButton()
        case .price:
            createPriceButton(price: text)
        case .addToCart:
            createAddToCartButton(text: text)
        case .useThisAddress:
            createUseThisAddressButton(text: text)
        case .savedAddress:
            createSevedAddressButton(text: text)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createCrossButton() {
        var config = UIButton.Configuration.plain()
        config.image = UIImage.cross
        config.cornerStyle = .capsule
        config.contentInsets = .zero
        self.configuration = config
    }
    
    private func createPriceButton(price: String) {
        var config = UIButton.Configuration.plain()

        var attributedTitle = AttributedString(price)
        attributedTitle.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        attributedTitle.foregroundColor = .black

        config.attributedTitle = attributedTitle
        config.baseForegroundColor = AppColor.Button.orang1
        config.background.backgroundColor = AppColor.Button.orang3
        config.cornerStyle = .capsule

        self.configuration = config
    }
    
    private func createAddToCartButton(text: String) {
        var config = UIButton.Configuration.plain()

        var attributedTitle = AttributedString("from \(text)€")
        attributedTitle.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        attributedTitle.foregroundColor = .brown

        config.attributedTitle = attributedTitle
        config.baseForegroundColor = .white
        config.background.backgroundColor = AppColor.Button.orang1
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6)

        self.configuration = config
    }
    
    private func createUseThisAddressButton(text: String) {
        var config = UIButton.Configuration.plain()

        var attributedTitle = AttributedString("\(text)")
        attributedTitle.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        attributedTitle.foregroundColor = .brown

        config.attributedTitle = attributedTitle
        config.baseForegroundColor = .white
        config.background.backgroundColor = AppColor.Button.orang1
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6)

        self.configuration = config
    }
    
    private func createSevedAddressButton(text: String) {
        var config = UIButton.Configuration.plain()
        
        var attributedTitle = AttributedString("📍\(text)")
        
        attributedTitle.font = .systemFont(ofSize: 14, weight: .medium)
        attributedTitle.foregroundColor = .black
        config.attributedTitle = attributedTitle
        config.baseForegroundColor = .black
        config.baseBackgroundColor = .lightGray
        config.cornerStyle = .capsule
        self.configuration = config
    }
}

extension Button {
    
    func updatePrice(_ price: Double) {
        var config = self.configuration
        var attributedTitle = AttributedString(String(format: "%.2f€", price))
        attributedTitle.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        attributedTitle.foregroundColor = .black
        config?.attributedTitle = attributedTitle
        self.configuration = config
    }
}
