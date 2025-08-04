//
//  BannerCell.swift
//  Dodo Pizza
//
//  Created by Zakhar on 03.08.25.
//

import Foundation
import UIKit
import SnapKit

final class BannerCell: UITableViewCell {
    
    private let label = BannerLabelView()
    private let carousel = BannerCarouselView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BannerCell {
    func setCarousel(with products: [ProductView]) {
        label.setText("Bestsellers")
        carousel.update(with: products)
    }
}

private extension BannerCell {
    func setupView() {
        contentView.addSubview(label)
        contentView.addSubview(carousel)
    }
    
    func setupConstraints() {
        label.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        carousel.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom)
            make.height.equalTo(125)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
