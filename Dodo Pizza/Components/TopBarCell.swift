//
//  Header.swift
//  dodo-pizza-project
//
//  Created by Zakhar on 19.06.25.
//

import UIKit
import SnapKit

class TopBarCell: UITableViewCell {
    
    private let headerImageView = ImageView(style: .logoHeader)
    
    private let accountButton = Button(style: .account)
    
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

// MARK: - Setup
private extension TopBarCell {
    
    func setupView() {
        contentView.addSubview(headerImageView)
        contentView.addSubview(accountButton)
    }
    
    func setupConstraints() {
        headerImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Layout.offset16)
            make.centerY.equalToSuperview()
            make.right.equalTo(contentView.snp.centerX)
        }
        
        accountButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().inset(Layout.offset16)
        }
    }
}
