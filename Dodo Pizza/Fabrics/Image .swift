//
//  Image .swift
//  dodo-pizza-work
//
//  Created by Zakhar on 29.06.25.
//

import Foundation
import UIKit

enum ImageStyle {
    case logoHeaderImage
    case bannerCellImage
    case productCellImage
    case ditailImage
    case cartImage
    case emptyView
}

final class Image: UIImageView {
    
    init(style: ImageStyle, imageUrl: String) {
        super.init(frame: .zero)
        
        switch style {
        
        case .logoHeaderImage: createLogoHeaderImage()
            
        case .bannerCellImage: createBannerCellImage()
            
        case .productCellImage:
            createMenuImage()
            
        case .ditailImage:
            createDetailImage()
            
        case .cartImage:
            createCartImage()
            
        case .emptyView:
            createCartEmptyImage()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createLogoHeaderImage() {
        self.image = UIImage(named: "logoDodoPizza")
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
    }
    
    func createBannerCellImage() {
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
        self.widthAnchor.constraint(equalToConstant: Layout.screenWidth * 0.20).isActive = true
        self.heightAnchor.constraint(equalToConstant: Layout.screenWidth * 0.20).isActive = true
    }
    
    func createDetailImage() {
        self.contentMode = .scaleAspectFit
        self.heightAnchor.constraint(equalToConstant: 0.70 * Layout.screenWidth).isActive = true
        self.widthAnchor.constraint(equalToConstant: 0.70 * Layout.screenWidth).isActive = true
    }
    
    func createMenuImage() {
        self.image = UIImage.hawaii
        self.contentMode = .scaleAspectFill
        self.heightAnchor.constraint(equalToConstant: 0.40 * Layout.screenWidth).isActive = true
        self.widthAnchor.constraint(equalToConstant: 0.40 * Layout.screenWidth).isActive = true
    }
    
    func createCartImage() {
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = true
    }
    
    func createCartEmptyImage() {
        self.image = UIImage(named: "empty view")
        self.heightAnchor.constraint(equalToConstant: 200).isActive = true
        self.widthAnchor.constraint(equalToConstant: 130).isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
    }
}
