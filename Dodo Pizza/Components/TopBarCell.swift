import UIKit
import SnapKit

protocol TopBarCellDelegate: AnyObject {
    func openAccountView()
}

class TopBarCell: UITableViewCell {
    
    var delegate: TopBarCellDelegate?
    
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

private extension TopBarCell {
    @objc func didTapAccountButton() {
        delegate?.openAccountView()
    }
}

// MARK: - Setup
private extension TopBarCell {
    
    func setupView() {
        accountButton.addTarget(self, action: #selector(didTapAccountButton), for: .touchUpInside)
        
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
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(Layout.offset16)
        }
    }
}
