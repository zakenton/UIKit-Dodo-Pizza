import UIKit
import SnapKit

protocol ICartBottomViewDelegate: AnyObject{
    func didTapCheckout()
}

final class CartBottomView: UIView {
    
    weak var delegate: ICartBottomViewDelegate?
    
    private let orderButton = Button(style: .checkout)
    private let priceLabel = Label(style: .cartPrice)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CartBottomView {
    func setTotalPrice(_ price: String) {
        priceLabel.text = price
    }
}

private extension CartBottomView {
    @objc func checkoutAction() {
        delegate?.didTapCheckout()
    }
}

private extension CartBottomView {
    
    func setupView() {
        addSubview(orderButton)
        addSubview(priceLabel)
        
        orderButton.addTarget(self, action: #selector(checkoutAction), for: .touchUpInside)
    }
    
    func setupConstraints() {
        priceLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Layout.offset16)
            make.left.equalToSuperview().inset(Layout.offset12)
            make.right.equalTo(snp.centerX).inset(Layout.offset12)
        }
        
        orderButton.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(Layout.offset24)
            make.left.equalTo(snp.centerX).inset(Layout.offset12)
            make.right.equalToSuperview().inset(Layout.offset12)
        }
    }
}
