//
//  Lebel.swift
//  dodo-pizza-work
//
//  Created by Zakhar on 29.06.25.
//

import Foundation
import UIKit

enum LabelStyle {
    case menuLabel
    
    case bannerTitleLabel
    case bannerPriceLabel
    
    case productCellLabel
    case productCellDescriptionLabel
    
    case detailVCDescriptionLebel
}

final class Label: UILabel {
    
    init(style: LabelStyle, text: String) {
        super.init(frame: .zero)
        switch style {
        case .menuLabel:
            createMenuLebel(text: text)
            
        case .bannerTitleLabel:
            createBannerTitleLabel(text: text)
            
        case .bannerPriceLabel:
            createBannerPriceLebel(text: text)
            
        case .productCellLabel:
            createProductCellLabel(text: text)
            
        case .productCellDescriptionLabel:
            createProductCellDescriptionLabel(text: text)
            
        case .detailVCDescriptionLebel:
            createDetailVCDescriptionLebel(text: text)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Menu
private extension Label {
    
    func createMenuLebel(text: String) {
        self.text = text
        self.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        self.textAlignment = .left
        self.textColor = AppColor.Label.black
    }
}

// MARK: - Banner
private extension Label {
    
    func createBannerTitleLabel(text: String) {
        self.text = text
        self.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        self.textAlignment = .left
        self.textColor = AppColor.Label.black
    }
    
    func createBannerPriceLebel(text: String) {
        self.text = text
        self.font = UIFont.systemFont(ofSize: 14)
        self.textAlignment = .left
        self.textColor = AppColor.Label.black
    }
}

// MARK: - Product Cell
private extension Label {
    
    func createProductCellLabel(text: String)  {
        self.text = text
        self.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        self.textAlignment = .left
        self.textColor = AppColor.Label.black
    }
    
    func createProductCellDescriptionLabel(text: String) {
        self.text = text
        self.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        self.textAlignment = .left
        self.textColor = AppColor.Label.gray
    }
}

private extension Label {
    
    func createDetailVCDescriptionLebel(text: String) {
        self.text = text
        self.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        self.textAlignment = .center
        self.textColor = AppColor.Label.gray
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
    }
}
