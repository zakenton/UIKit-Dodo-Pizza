import UIKit
import SnapKit

protocol IQuantityViewDelegate: AnyObject {
    func didTapPlusButton()
    func didTapMinusButton()
}

final class QuantityView: UIView {
    
    weak var delegate: IQuantityViewDelegate?
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        return button
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
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
        
        plusButton.addTarget(self, action: #selector(plusTapped), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QuantityView {
    func setQuantity(_ count: UInt) {
        quantityLabel.text = String(count)
    }
}

private extension QuantityView {
    @objc func plusTapped() {
        delegate?.didTapPlusButton()
    }
    
    @objc func minusTapped() {
        delegate?.didTapMinusButton()
    }
}

// MARK: - Setup
private extension QuantityView {
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
