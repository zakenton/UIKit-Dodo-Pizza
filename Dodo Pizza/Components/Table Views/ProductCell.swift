//
//  ProductsCell.swift
//  dodo-pizza-work
//
//  Created by Zakhar on 29.06.25.
//

import Foundation
import UIKit
import SnapKit

protocol ProductCellDelegate: AnyObject {
    func didTapPriceButton(for product: ProductView)
}

final class ProductCell: UITableViewCell {
    
    weak var delegate: ProductCellDelegate?
    private var product: ProductView?
    
    var verticalStackView: UIStackView = {
        var stackView = UIStackView.init()
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .leading
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 15, bottom: 12, trailing: 0)
        return stackView
    }()
    
    var title = Label(style: .productCellTitle)
    
    var descriptions = Label(style: .productCellDescription)
    
    var image = ImageView(style: .productCell)
    
    var priceButton = Button(style: .price("0.00"))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        priceButton.addTarget(self, action: #selector(priceButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with product: ProductView) {
        self.product = product
        image.image = UIImage(named: product.imageURL)
        title.text = product.name
        descriptions.text = product.description
        priceButton.updatePrice(product.price)
    }
}

// MARK: - Setup
private extension ProductCell {
    
    @objc func priceButtonTapped() {
        guard let product = product else { return }
        delegate?.didTapPriceButton(for: product)
    }
    
    func setupViews() {
        contentView.addSubview(image)
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(title)
        verticalStackView.addArrangedSubview(descriptions)
        verticalStackView.addArrangedSubview(priceButton)
    }
    
    func setupConstraints() {
        image.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(Layout.offset16)
            make.centerY.equalTo(contentView)
            make.top.bottom.greaterThanOrEqualTo(contentView).priority(.high)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.right.equalTo(contentView).inset(Layout.offset16)
            make.left.equalTo(image.snp.right).offset(Layout.offset16)
            make.top.bottom.equalTo(contentView).inset(Layout.offset16)
        }
        
        priceButton.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.height.equalTo(30)
        }
    }
}

