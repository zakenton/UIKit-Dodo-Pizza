//
//  Untitled.swift
//  Dodo Pizza
//
//  Created by Zakhar on 13.06.25.
//

import UIKit
import SnapKit

class CategoryCarouselHeader: UIView {
    
    var selectedCategory: CategoryView = .pizza
    
    private var categories: [CategoryView] = []
    
    var onCategorySelect: ((CategoryView) -> Void)?
    
    lazy var collectionView: UICollectionView = CollectionViewFactory.makeCollectionView(delegate: self)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryCarouselHeader {
    
    func update(categories: [CategoryView], selectedCategory: CategoryView) {
        self.categories = categories
        self.selectedCategory = selectedCategory
        collectionView.reloadData()
    }
}



// MARK: Setup
private extension CategoryCarouselHeader {
    func setupView() {
        setupCollectionView()
        addSubview(collectionView)
        setupConstraints()
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupCollectionView() {
        collectionView.registerCell(CategoryCell.self)
    }
}

// MARK: Delegate, DataSource
extension CategoryCarouselHeader: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(indexPath) as CategoryCell
        
        let titel = categories[indexPath.item]
        let isSelected = titel == selectedCategory
        cell.configure(title: titel.rawValue, isSelected: isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = categories[indexPath.item]
        guard category != selectedCategory else { return }
        
        selectedCategory = category
        collectionView.reloadData()
        onCategorySelect?(category)
    }
}

