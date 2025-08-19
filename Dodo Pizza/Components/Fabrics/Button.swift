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
    case price(String)
    case addToCart(String)
    case useThisAddress(String)
    case savedAddress(String)
    case additional(String)
    case checkout
    case account
}

final class Button: UIButton {
    
    private let style: ButtonStyle
    
    init(style: ButtonStyle) {
        self.style = style
        super.init(frame: .zero)
        configureButton(style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureButton(style: ButtonStyle) {
        switch style {
        case .cross:
            configureCrossButton()
            
        case .price(let price):
            configurePriceButton(price: price)
            
        case .addToCart(let text):
            configureActionButton(text: "\(text)€", backgroundColor: AppColor.Button.orang1)
            
        case .useThisAddress(let text):
            configureActionButton(text: text, backgroundColor: AppColor.Button.orang1)
            
        case .savedAddress(let text):
            configureSavedAddressButton(text: text)
            
        case .additional(let text):
            configureAdditionalButton(text: text)
            
        case .checkout:
            configureActionButton(text: "Checkout", backgroundColor: AppColor.Button.orang1)
            
        case .account:
            configureAccountButton()
        }
    }
    
    // MARK: - Button Configurations
    
    private func configureCrossButton() {
        var config = UIButton.Configuration.plain()
        config.image = UIImage.cross
        config.cornerStyle = .capsule
        config.contentInsets = .zero
        self.configuration = config
    }
    
    private func configurePriceButton(price: String) {
        var config = baseButtonConfiguration()
        
        var attributedTitle = AttributedString(price)
        attributedTitle.font = .boldSystemFont(ofSize: 16)
        attributedTitle.foregroundColor = .black

        config.attributedTitle = attributedTitle
        config.background.backgroundColor = AppColor.Button.orang3
        config.baseForegroundColor = AppColor.Button.orang1
        
        self.configuration = config
    }
    
    private func configureActionButton(text: String, backgroundColor: UIColor) {
        var config = baseButtonConfiguration()
            
            var attributedTitle = AttributedString(text)
            attributedTitle.font = .systemFont(ofSize: 16, weight: .medium)
            attributedTitle.foregroundColor = .white

            config.attributedTitle = attributedTitle
            config.background.backgroundColor = backgroundColor
            config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6)
            config.baseForegroundColor = .white
            
            self.configuration = config
    }
    
    private func configureSavedAddressButton(text: String) {
        var config = baseButtonConfiguration()
        
        var attributedTitle = AttributedString("📍\(text)")
        attributedTitle.font = .systemFont(ofSize: 14, weight: .regular)
        attributedTitle.foregroundColor = .black
        
        config.attributedTitle = attributedTitle
        config.background.backgroundColor = .systemGray6
        config.baseForegroundColor = .black
        
        self.configuration = config
    }
    
    private func configureAdditionalButton(text: String) {
        setTitle(text, for: .normal)
        setTitleColor(.orange, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
    }
    
    private func configureAccountButton() {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "line.3.horizontal")
        config.preferredSymbolConfigurationForImage = .init(pointSize: 18, weight: .semibold)
        config.contentInsets = .zero
        self.configuration = config

        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
    }


    // MARK: - Helpers
    
    private func baseButtonConfiguration() -> UIButton.Configuration {
        var config = UIButton.Configuration.plain()
        config.cornerStyle = .capsule
        return config
    }
}

extension Button {
    func updatePrice(_ price: Double) {
        switch style {
        case .price:
            updatePriceButton(price)
        case .addToCart:
            updateAddToCartButton(price)
        default:
            break
        }
    }
    
    private func updatePriceButton(_ price: Double) {
        var config = self.configuration ?? baseButtonConfiguration()
        
        var attributedTitle = AttributedString(String(format: "from %.2f€", price))
        attributedTitle.font = .boldSystemFont(ofSize: 16)
        attributedTitle.foregroundColor = .black

        config.attributedTitle = attributedTitle
        config.background.backgroundColor = AppColor.Button.orang3
        config.baseForegroundColor = AppColor.Button.orang1
        
        self.configuration = config
    }
    
    private func updateAddToCartButton(_ price: Double) {
        var config = self.configuration ?? baseButtonConfiguration()
        
        var attributedTitle = AttributedString(String(format: "%.2f€", price))
        attributedTitle.font = .systemFont(ofSize: 16, weight: .medium)
        attributedTitle.foregroundColor = .white

        config.attributedTitle = attributedTitle
        config.background.backgroundColor = AppColor.Button.orang1
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6)
        config.baseForegroundColor = .white
        
        self.configuration = config
    }
}
