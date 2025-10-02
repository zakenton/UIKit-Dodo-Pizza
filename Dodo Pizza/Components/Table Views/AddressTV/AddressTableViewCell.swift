import UIKit
import CoreLocation

final class AddressTableViewCell: UITableViewCell {

    private let iconLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 16, weight: .semibold)
        return l
    }()

    private let titleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 15, weight: .medium)
        return l
    }()

    private let subtitleLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13)
        l.textColor = .secondaryLabel
        l.numberOfLines = 2
        return l
    }()

    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        addViews()
        setupConstraints()
        accessoryType = .disclosureIndicator
        selectionStyle = .default
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

private extension AddressTableViewCell {
    func setupView() {
        contentView.backgroundColor = .white
    }

    func addViews() {
        contentView.addSubview(iconLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
    }

    func setupConstraints() {
        iconLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(28)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.equalTo(iconLabel.snp.right).offset(12)
            make.right.equalToSuperview().inset(16)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.left.right.equalTo(titleLabel)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}

extension AddressTableViewCell {
    func configure(address: Address) {
        iconLabel.text = address.label.emoji
        titleLabel.text = address.label.rawValue
        subtitleLabel.text = "\(address.address), \(address.zipcode) \(address.city)"
    }
}

private extension Mark {
    var emoji: String {
        switch self {
        case .home: return "🏠"
        case .work: return "💼"
        case .restaurant: return "🍽️"
        case .custom: return "📍"
        }
    }
}
