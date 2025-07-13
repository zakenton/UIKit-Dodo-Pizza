//
//  Untitled.swift
//  dodo-pizza-project
//
//  Created by Zakhar on 23.06.25.
//

import UIKit
import SnapKit
final class DitailSegmentControl: UIControl {
    
    private var options: [ProductOption] = []
    private var buttons: [UIButton] = []
    private var sliderView = UIView()
    private var sliderLeftConstraint: Constraint?
    
    var selectedIndex: Int = 0 {
        didSet {
            sendActions(for: .valueChanged)
        }
    }
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 0
        view.distribution = .fillEqually
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        selectIndex(sender.tag, animated: true)
    }
}


extension DitailSegmentControl {
    
    func setOptions(by options: [ProductOption]) {
        resetOptions()
        self.options = options
        
        setupButtons()
        setupSlider()
        
        if let selectedIndex = options.firstIndex(where: { $0.isSelected }) {
            selectIndex(selectedIndex, animated: false)
        } else {
            selectIndex(0, animated: false)
        }
    }
    
    func resetOptions() {
        options.removeAll()
        buttons.forEach { $0.removeFromSuperview() }
        buttons.removeAll()
        
        sliderView.removeFromSuperview()
    }
    
    func reset() {
        guard !options.isEmpty else { return }
        selectIndex(0, animated: false)
    }
}


// MARK: - SetupConstraint
extension DitailSegmentControl {
    
    private func setupView() {
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        layer.cornerRadius = 15
        clipsToBounds = true
        
        addSubview(stackView)
        stackView.snp.makeConstraints {make in 
            make.edges.equalToSuperview()
        }
    }
    
    private func setupButtons() {
        for (index, option) in options.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(option.option, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            stackView.addArrangedSubview(button)
            buttons.append(button)
        }
    }
    
    private func setupSlider() {
        guard options.count > 0 else { return }
        
        sliderView.backgroundColor = .white
        sliderView.layer.cornerRadius = 13
        insertSubview(sliderView, belowSubview: stackView)
        
        sliderView.snp.makeConstraints {make in
            make.top.equalToSuperview().inset(3)
            make.bottom.equalToSuperview().inset(3)
            make.width.equalToSuperview().multipliedBy(1.0 / CGFloat(options.count))
            sliderLeftConstraint = make.left.equalToSuperview().constraint
        }
        layoutIfNeeded()
    }
}


extension DitailSegmentControl {
    
    private func selectIndex(_ index: Int, animated: Bool) {
        
        guard index >= 0 && index < options.count else {return}
        selectedIndex = index
        
        let buttonWidth = frame.width / CGFloat(options.count)
        sliderLeftConstraint?.update(inset: buttonWidth * CGFloat(index))
        
        if animated {
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
                self.layoutIfNeeded()
            }, completion: nil)
        } else {
            layoutIfNeeded()
        }
    }
}
