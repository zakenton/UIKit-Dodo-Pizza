//
//  BanerCell.swift
//  ListOfProduct
//
//  Created by Zakhar on 11.06.25.
//

import Foundation
import SnapKit
import UIKit

class BannerCarouselView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: Layout.screenWidth * 0.6, height: Layout.screenWidth * 0.25)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("error")
    }
    
    private var banners: [ProductView] = []
    
    func update(with products: [ProductView]) {
        banners = products
        collectionView.reloadData()
    }
}
// MARK: - Setup
private extension BannerCarouselView {
    func setupView() {
        setupCollectionView()
        addSubview(collectionView)
        setupConstraint()
    }
    
    func setupConstraint() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }
    
    func setupCollectionView() {
        collectionView.registerCell(BannerCollectionViewCell.self)
    }
}

// MARK: Delegate, DataSource
extension BannerCarouselView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(indexPath) as BannerCollectionViewCell
        cell.update(banners[indexPath.row])
        return cell
    }
}
