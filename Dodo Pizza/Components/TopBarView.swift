//
//  Header.swift
//  dodo-pizza-project
//
//  Created by Zakhar on 19.06.25.
//

import UIKit
import SnapKit

class TopBarView: UIView {
    
    private let headerImageView = ImageView(style: .logoHeader)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup
private extension TopBarView {
    
    func setupView() {
        addSubview(headerImageView)
    }
    
    func setupConstraints() {
        headerImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Layout.offset6)
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.lessThanOrEqualToSuperview().multipliedBy(0.8)
        }
    }
}
