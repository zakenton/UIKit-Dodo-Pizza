import UIKit
import SnapKit

final class OrderView: UIView {
    
    private var restorantsTableView = MapTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OrderView {
    func setupTable(with restorants: [Address]) {
        restorantsTableView.fetchAddress(with: restorants)
    }
}

private extension OrderView {
    
    func setupView() {
        self.addSubview(restorantsTableView)
    }
    
    func setupConstraints() {
        restorantsTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(Layout.offset12)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
