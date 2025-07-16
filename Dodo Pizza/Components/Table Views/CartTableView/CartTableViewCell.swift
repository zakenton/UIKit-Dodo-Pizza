//
//  CartTableViewCell.swift
//  Dodo Pizza
//
//  Created by Zakhar on 16.07.25.
//

import Foundation
import UIKit
import SnapKit

import UIKit
import SnapKit

final class CartTableViewCell: UITableViewCell {

    // MARK: - UI
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 1
        return label
    }()

    private let optionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 1
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()

    private let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Изменить", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return button
    }()
    
    private let quantityCounter = QuantityControll()

    private let removeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .gray
        return button
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("Cell height: \(self.frame.height)")
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CartTableViewCell {
    func configure(with model: ProductCartViewModel) {
        
        productImageView.image = UIImage(named: model.imageURL)
        
        titleLabel.text = model.name
        
        var options = "\(model.size), \(model.dough)"
        if !model.additive.isEmpty {
            options += ", \(model.additive)"
        }
        optionLabel.text = options
        
        priceLabel.text = model.price
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

    func setupConstraints() {
        productImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(Layout.offset16)
            make.size.equalTo(80)
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

