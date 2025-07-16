//
//  QuantityControll.swift
//  Dodo Pizza
//
//  Created by Zakhar on 16.07.25.
//


import Foundation
import UIKit
import SnapKit

final class QuantityControll: UIControl {
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        return button
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "10"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let minusButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.frame.size = CGSize(width: 30, height: 30)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addViews()
        setupConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QuantityControll {
    func setQuantity(_ count: String) {
        quantityLabel.text = count
    }
}

extension QuantityControll {
    
}

// MARK: - Setup
private extension QuantityControll {
    func setupView() {
        layer.cornerRadius = 15
        backgroundColor = .gray
        layer.shadowRadius = .greatestFiniteMagnitude
    }
    
    func addViews() {
        addSubview(minusButton)
        addSubview(plusButton)
        addSubview(quantityLabel)
    }
    
    func setupConstraints() {
        snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 80, height: 28))
        }
        
        quantityLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        minusButton.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
            make.right.equalTo(quantityLabel.snp.left).offset(2)
        }
        
        plusButton.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.left.equalTo(quantityLabel.snp.right).offset(2)
        }
    }
}
