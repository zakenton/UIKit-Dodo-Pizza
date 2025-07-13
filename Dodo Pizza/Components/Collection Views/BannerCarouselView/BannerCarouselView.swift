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
    
    lazy var collectionView: UICollectionView = CollectionViewFactory.makeBannerCarousel(delegate: self)
    
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
