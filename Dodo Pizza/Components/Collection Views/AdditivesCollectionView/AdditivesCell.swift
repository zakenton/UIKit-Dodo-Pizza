//
//  AdditivesCell.swift
//  Dodo Pizza
//
//  Created by Zakhar on 11.07.25.
//

import Foundation
import UIKit
import SnapKit

final class AdditivesCell: UICollectionViewCell {

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        setupView()
        configureSubviews()
        addSubviews()
        setupConstraints()
    }

    private func setupView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
    }

    private func configureSubviews() {
        imageView.contentMode = .scaleAspectFit

        titleLabel.font = .systemFont(ofSize: 13, weight: .medium)
        titleLabel.textAlignment = .center

        priceLabel.font = .boldSystemFont(ofSize: 14)
        priceLabel.textAlignment = .center
    }

    private func addSubviews() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
    }

    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.left.right.equalToSuperview().inset(6)
            make.height.equalTo(100) // фиксированная высота, можно адаптировать
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(4)
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(4)
            make.bottom.equalToSuperview().inset(6)
        }
    }
}

extension AdditivesCell {
    func configure(with option: ProductAdditiveView, isSelected: Bool = false) {
        imageView.image = UIImage(named: option.imageURL)
        titleLabel.text = option.name
        priceLabel.text = String(format: "%.2f ₽", option.price)
        highlight(option.isSelected)
    }

    private func highlight(_ flag: Bool) {
        contentView.layer.borderWidth = flag ? 2 : 0
        contentView.layer.borderColor = flag ? UIColor.orange.cgColor : nil
    }
}
