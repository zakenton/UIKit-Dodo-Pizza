//
//  CartTableViewCell.swift
//  Dodo Pizza
//
//  Created by Zakhar on 16.07.25.
//

import Foundation
import UIKit
import SnapKit

protocol ICartTableViewCellDelegate: AnyObject {
    func didTapIncrementQuantity(for cartId: UUID)
    func didTapDecrementQuantity(for cartId: UUID)
    func didTapDeleteProduct(with cartId: UUID)
    func didTapChangeButton(for product: ProductCart)
}

final class CartTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    weak var delegate: ICartTableViewCellDelegate?
    private var product: ProductCart?
    
    // MARK: - UI Components
    
    private let productImageView = Image(style: .cartImage, imageUrl: "")
    private let titleLabel = Label(style: .cartCellTitleLabel, text: "")
    private let optionLabel = Label(style: .cartCellOptionLabel, text: "")
    private let priceLabel = Label(style: .cartCellPriceLabel, text: "")
    private let quantityCounter = QuantityView()
    private let editButton = Button(style: .additional("edit"))
    private let removeButton = Button(style: .cross)
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupActions()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configuration

extension CartTableViewCell {
    func configure(with product: ProductCart) {
        self.product = product
        productImageView.image = UIImage(named: product.imageURL)
        titleLabel.text = product.name
        optionLabel.text = formattedOptionsString(for: product)
        priceLabel.text = String(format: "%.2f €", product.price)
        quantityCounter.setQuantity(product.quantity)
    }
    
    private func formattedOptionsString(for product: ProductCart) -> String {
        var optionsParts = [String]()
        
        if let selectedSize = product.size?.first(where: { $0.isSelected }) {
            optionsParts.append(selectedSize.option)
        }
        
        if let selectedDough = product.dough?.first(where: { $0.isSelected }) {
            optionsParts.append(selectedDough.option)
        }
        
        if let selectedAdditives = product.additive?
            .filter({ $0.isSelected })
            .map({ $0.name }),
           !selectedAdditives.isEmpty {
            let additivesString = selectedAdditives.joined(separator: ", ")
            optionsParts.append(additivesString)
        }
        
        return optionsParts.joined(separator: ", ")
    }
}


// MARK: - QuantityViewDelegate

extension CartTableViewCell: IQuantityViewDelegate {
    func didTapPlusButton() {
        guard let product = product else { return }
        delegate?.didTapIncrementQuantity(for: product.cartItemId)
    }
    
    func didTapMinusButton() {
        guard let product = product else { return }
        delegate?.didTapDecrementQuantity(for: product.cartItemId)
    }
}

// MARK: - Action Handlers

private extension CartTableViewCell {
    @objc func changeButtonTapped() {
        guard let product = product else { return }
        delegate?.didTapChangeButton(for: product)
    }
    
    @objc func deleteButtonTapped() {
        guard let product = product else { return }
        delegate?.didTapDeleteProduct(with: product.cartItemId)
    }
}

// MARK: - UI Setup
private extension CartTableViewCell {
    func setupView() {
        contentView.addSubview(productImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(optionLabel)
        contentView.addSubview(removeButton)
        
        contentView.addSubview(quantityCounter)
        contentView.addSubview(priceLabel)
        contentView.addSubview(editButton)
    }
    //MARK: Setup Actions
    func setupActions() {
        editButton.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
        removeButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        quantityCounter.delegate = self
    }

    //MARK: Setup Constraints
    func setupConstraints() {
        productImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(16)
            make.width.equalTo(80)
            make.height.equalTo(80).priority(.high)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Layout.offset12)
            make.left.equalTo(productImageView.snp.right).offset(Layout.offset8)
            make.right.equalTo(removeButton.snp.left).offset(-Layout.offset6)
        }
        
        optionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.left.equalTo(productImageView.snp.right).offset(Layout.offset8)
            make.right.equalTo(removeButton.snp.left).offset(-Layout.offset6)
            make.bottom.equalTo(productImageView.snp.bottom)
        }
        
        removeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Layout.offset8)
            make.right.equalToSuperview().inset(Layout.offset8)
            make.size.equalTo(20)
        }
        
        quantityCounter.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(Layout.offset6)
            make.right.equalTo(contentView.snp.right).inset(Layout.offset6)
            make.bottom.equalTo(contentView.snp.bottom).inset(Layout.offset6)
        }
        
        editButton.snp.makeConstraints { make in
            make.centerY.equalTo(quantityCounter.snp.centerY)
            make.right.equalTo(quantityCounter.snp.left).offset(-5)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerY.equalTo(quantityCounter.snp.centerY)
            make.left.equalTo(productImageView.snp.left)
        }
    }
}

