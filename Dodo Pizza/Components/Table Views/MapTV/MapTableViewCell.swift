import UIKit
import SnapKit

final class MapTableViewCell: UITableViewCell {
    //MARK: UIElements
    private let markLabel = Label(style: .mapMark)
    
    private let addressLabel = Label(style: .mapAddress)
    
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
//MARK: Configure
extension MapTableViewCell {
    func configure(address: Address) {
        markLabel.text = address.label.rawValue
        addressLabel.text = address.address
    }
}

//MARK: Setup View
private extension MapTableViewCell {
    
    func setupView() {
        contentView.addSubview(markLabel)
        contentView.addSubview(addressLabel)
    }
    
    func setupConstraints() {
        markLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Layout.offset6)
            make.left.right.equalToSuperview().inset(Layout.offset16)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(markLabel.snp.bottom).offset(Layout.offset6)
            make.left.right.equalToSuperview().inset(Layout.offset16)
            make.bottom.equalToSuperview().inset(Layout.offset6)
        }
    }
}
