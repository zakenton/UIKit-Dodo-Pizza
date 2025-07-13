//
//  CategoryButtonCollectionViewCell.swift
//  Dodo Pizza
//
//  Created by Zakhar on 14.06.25.
//

import Foundation
import UIKit
import SnapKit

class CategoryCell: UICollectionViewCell {
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
        button.backgroundColor = UIColor.systemGray5
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.isUserInteractionEnabled = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Configure
extension CategoryCell {
    func configure(title: String, isSelected: Bool) {
        button.setTitle(title, for: .normal)
        if isSelected {
            button.setTitleColor(.black, for: .normal)
        } else {
            button.setTitleColor(.systemGray, for: .normal)
        }
    }
}

// MARK: Setup
extension CategoryCell {
    private func setupView() {
        contentView.addSubview(button)
    }
    
    private func setupLayout() {
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
    }
}
