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
    
    case mapMarkLabel
    case mapAddressLabel
    
    case cartCellTitleLabel
    case cartCellOptionLabel
    case cartCellPriceLabel
    case cartEmptyTitleLabel
    case cartEmptyDescriptionLabel
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
            
        case .mapMarkLabel:
            createMapMarkLabel(text: text)
            
        case .mapAddressLabel:
            createMapAddressLebel(text: text)
            
        case .cartCellTitleLabel:
            createCartTitleLabel(text: text)
            
        case .cartCellOptionLabel:
            createCartOptionLabel(text: text)
            
        case .cartCellPriceLabel:
            createCartPriceLabel(text: text)
            
        case .cartEmptyTitleLabel:
            createCartEmptyTitleLabel(text: text)
            
        case .cartEmptyDescriptionLabel:
            createCartEmptyDescriptionLabel(text: text)
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


//MARK: DetailVC
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

//MARK: MapVC
private extension Label {
    func createMapMarkLabel(text: String) {
        self.text = text
        self.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        self.textAlignment = .left
        self.textColor = AppColor.Label.black
    }
    
    func createMapAddressLebel(text: String) {
        self.text = text
        self.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        self.textAlignment = .left
        self.textColor = AppColor.Label.gray
    }
}

//MARK: Cart TableViewCell
private extension Label {
    func createCartTitleLabel(text: String) {
        self.font = UIFont.boldSystemFont(ofSize: 16)
        self.numberOfLines = 1
    }
    
    func createCartOptionLabel(text: String) {
        self.font = UIFont.systemFont(ofSize: 14)
        self.textColor = AppColor.Label.gray
        self.numberOfLines = 1
    }
    
    func createCartPriceLabel(text: String) {
        self.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        self.textColor = AppColor.Label.black
    }
}

//MARK: Cart Empty View

private extension Label {
    func createCartEmptyTitleLabel(text: String) {
        self.text = text
        self.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        self.textAlignment = .center
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func createCartEmptyDescriptionLabel(text: String) {
        self.text = text
        self.numberOfLines = 0
        self.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        self.textAlignment = .center
    }
}
