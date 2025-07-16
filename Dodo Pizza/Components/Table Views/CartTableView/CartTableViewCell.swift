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
        imageView.layer.cornerRadius = 12
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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CartTableViewCell {
    func configure(with model: ProductCartViewModel) {
        // Картинка (подключи Kingfisher/SDWebImage если нужны внешние URL)
        productImageView.image = UIImage(named: model.imageURL)
        // Название пиццы
        titleLabel.text = model.name
        // Описание опций
        var options = "\(model.size), \(model.dough)"
        if !model.additive.isEmpty {
            options += ", \(model.additive)"
        }
        optionLabel.text = options
        // Цена
        priceLabel.text = model.price
    }
}

// MARK: - UI Setup
private extension CartTableViewCell {
    func setupView() {
        contentView.addSubview(productImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(optionLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(editButton)
        contentView.addSubview(removeButton)
    }

    func setupConstraints() {
        
        contentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }
        // Картинка
        productImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Layout.offset12)
            make.top.equalToSuperview().offset(Layout.offset12)
            make.size.equalTo(CGSize(width: 80, height: 80))
        }

        // Крестик
        removeButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Layout.offset12)
            make.top.equalToSuperview().offset(Layout.offset12)
            make.size.equalTo(20)
        }

        // Название (title)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Layout.offset12)
            make.left.equalTo(productImageView.snp.right).offset(Layout.offset8)
            make.right.equalTo(removeButton.snp.left).offset(Layout.offset8)
        }

        // Описание (optionLabel)
        optionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.left.right.equalTo(titleLabel)
            make.bottom.equalTo(productImageView.snp.bottom)
        }

        // Кнопка "Изменить"
        editButton.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottom).offset(2)
            make.right.equalToSuperview().inset(Layout.offset12)
            make.bottom.equalToSuperview().inset(Layout.offset8)
        }
    }
}

