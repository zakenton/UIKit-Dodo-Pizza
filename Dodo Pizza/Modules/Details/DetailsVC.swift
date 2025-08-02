//
//  DetailsVC.swift
//  Dodo Pizza
//
//  Created by Zakhar on 02.07.25.
//

import Foundation
import UIKit
import SnapKit

final class DetailsVC: UIViewController {
    
    //MARK: Views
    private let scrollView = UIScrollView()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        return view
    }()

    private let dismissViewButton = Button(style: .cross)
    private let addToCartButton = Button(style: .addToCart("0.00"))
    private let productImage = Image(style: .ditailImage, imageUrl: "")
    private let productDescription = Label(style: .detailVCDescriptionLebel, text: "")
    private let sizeSegmentControl = DitailSegmentControl()
    private let doughSegmentControl = DitailSegmentControl()
    private let additivesCollection = AdditivesCollectionView()
    
    private let presenter: IDetailPresenterInput?
    
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DetailVC init ✅")
        setupView()
        presenter?.viewDidLoad()
        
        additivesCollection.onSelect = { [weak self] index in
            self?.presenter?.didSelectAdditive(index: index)
        }
    }
    
    deinit {
        print("DetailVC DEINIT ✅")
    }
    
    init(presenter: IDetailPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - View Input
extension DetailsVC: IDetailViewInput {
    func setPrice(price: Double) {
        addToCartButton.updatePrice(price)
    }
    
    func setImage(imageURL: String) {
        productImage.image = UIImage(named: imageURL)
    }
    
    func setDescription(description: String) {
        productDescription.text = description
    }
    
    func setSize(option: [ProductOption]) {
        sizeSegmentControl.setOptions(by: option)
        sizeSegmentControl.isHidden = false
    }
    
    func setDough(option: [ProductOption]) {
        doughSegmentControl.setOptions(by: option)
        doughSegmentControl.isHidden = false
    }
    
    func setAdditives(option: [ProductAdditiveView]) {
        additivesCollection.update(with: option)
        additivesCollection.isHidden = false
    }
    
    func updateAdditive(at index: Int, isSelected: Bool) {
        additivesCollection.toggleSelection(in: index, newValue: isSelected)
    }
}

// MARK: - View Output
private extension DetailsVC  {
    
    @objc func dismissView() {
        presenter?.didTapCloseButton()
    }
    
    @objc func addToCart() {
        presenter?.didTapAddToCart()
    }
    
    @objc func updateSelectedSize() {
        let index = sizeSegmentControl.selectedIndex
        print(index)
        presenter?.didSelectSize(index: index)
    }
    
    @objc func updateSelectedDough() {
        let index = doughSegmentControl.selectedIndex
        print(index)
        presenter?.didSelectDough(index: index)
    }
}




// MARK: - Setup View
private extension DetailsVC {
    func setupView() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = CGColor(gray: 0.5, alpha: 0.9)
        
        addSubViews()
        addTargets()
        setupConstraints()
    }
    //MARK: addSubViews
    func addSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        stackView.addArrangedSubview(productImage)
        stackView.addArrangedSubview(productDescription)
        stackView.addArrangedSubview(sizeSegmentControl)
        stackView.addArrangedSubview(doughSegmentControl)
        stackView.addArrangedSubview(addToCartButton)
        stackView.addArrangedSubview(additivesCollection)
        
        sizeSegmentControl.isHidden = true
        doughSegmentControl.isHidden = true
        additivesCollection.isHidden = true
    }
    //MARK: addTargets
    func addTargets() {
        dismissViewButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        addToCartButton.addTarget(self, action: #selector(addToCart), for: .touchUpInside)
        sizeSegmentControl.addTarget(self, action: #selector(updateSelectedSize), for: .valueChanged)
        doughSegmentControl.addTarget(self, action: #selector(updateSelectedDough), for: .valueChanged)
    }
    //MARK: setupConstraints
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        productImage.snp.makeConstraints { make in
            make.height.equalTo(Layout.screenWidth * 0.90)
            
        }
        
        sizeSegmentControl.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Layout.offset16)
            make.height.equalTo(30)
        }
        
        doughSegmentControl.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(Layout.offset16)
            make.height.equalTo(30)
        }
        
        addToCartButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.right.equalToSuperview().inset(Layout.offset16)
        }
        
        additivesCollection.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
        }
    }
}
