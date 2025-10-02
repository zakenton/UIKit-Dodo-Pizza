import UIKit
import SnapKit

final class SelectorView: UIControl {
    private let deliveryButton = UIButton(type: .system)
    private let orderButton = UIButton(type: .system)
    private let sliderView = UIView()
    private var sliderLeftConstraint: Constraint?
    private var sliderWidthConstraint: Constraint?
    
    private(set) var selectedIndex: Int = 0
    
    func setSelectedIndex(_ index: Int, animated: Bool = true) {
        guard index == 0 || index == 1 else { return }
        moveSlider(to: index, animated: animated)
        updateButtonColors(for: index)
        if selectedIndex != index {
            selectedIndex = index
            sendActions(for: .valueChanged)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setSelectedIndex(0, animated: false)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setSelectedIndex(0, animated: false)
    }
    
    private func setupUI() {
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        layer.cornerRadius = 16
        clipsToBounds = true
        
        sliderView.backgroundColor = .orange
        sliderView.layer.cornerRadius = 16
        addSubview(sliderView)
        sliderView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(2)
            sliderLeftConstraint = make.left.equalToSuperview().inset(2).constraint
            sliderWidthConstraint = make.width.equalToSuperview().multipliedBy(0.5).offset(-6).constraint
        }
        
        setupButton(deliveryButton, title: "Delivery", tag: 0)
        setupButton(orderButton, title: "Order", tag: 1)
        let stackView = UIStackView(arrangedSubviews: [deliveryButton, orderButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupButton(_ button: UIButton, title: String, tag: Int) {
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.tag = tag
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        setSelectedIndex(sender.tag)
    }
    
    private func moveSlider(to index: Int, animated: Bool) {
        self.layoutIfNeeded()
        let sliderOffset = (self.bounds.width / 2) * CGFloat(index)
        sliderLeftConstraint?.update(offset: sliderOffset + 2)
        UIView.animate(withDuration: animated ? 0.3 : 0) {
            self.layoutIfNeeded()
        }
    }
    
    private func updateButtonColors(for index: Int) {
        deliveryButton.setTitleColor(index == 0 ? .white : .black, for: .normal)
        orderButton.setTitleColor(index == 1 ? .white : .black, for: .normal)
    }
}
