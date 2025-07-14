//
//  Untitled.swift
//  Dodo Pizza
//
//  Created by Zakhar on 13.06.25.
//

import UIKit
import SnapKit

final class CategoryCarouselHeader: UIView {
    
    var selectedCategory: CategoryView = .pizza
    private var categories: [CategoryView] = []
    var onCategorySelect: ((CategoryView) -> Void)?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 80, height: 35)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.showsHorizontalScrollIndicator = false
        view.delegate = self
        view.dataSource = self
        
        return view
    }()
    
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
    
    func fetchCategoies(categories: [CategoryView]) {
        self.categories = categories
        collectionView.reloadData()
    }
}

// MARK: Setup
private extension CategoryCarouselHeader {
    func setupView() {
        collectionView.registerCell(CategoryCell.self)
        addSubview(collectionView)
        setupConstraints()
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
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
    
    /// reload chenged buttons
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let newSelectedCategory = categories[indexPath.item]
        guard newSelectedCategory != selectedCategory else { return }
        
        /// find index of preview selected category
        if let previousIndex = categories.firstIndex(of: selectedCategory) {
            let previousIndexPath = IndexPath(item: previousIndex, section: 0)
            selectedCategory = newSelectedCategory
            let newIndexPath = indexPath
            
            // Перезагрузим только старую и новую ячейку
            collectionView.reloadItems(at: [previousIndexPath, newIndexPath])
        } else {
            selectedCategory = newSelectedCategory
            collectionView.reloadItems(at: [indexPath])
        }
        
        onCategorySelect?(newSelectedCategory)
    }
}

