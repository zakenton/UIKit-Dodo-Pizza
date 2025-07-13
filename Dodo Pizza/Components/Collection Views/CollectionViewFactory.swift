//
//  CollectionView.swift
//  Dodo Pizza
//
//  Created by Zakhar on 10.07.25.
//

import Foundation
import UIKit

final class CollectionViewFactory {
    
    static func makeCollectionView(delegate: UICollectionViewDelegate & UICollectionViewDataSource) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 80, height: 35)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .white
        view.showsHorizontalScrollIndicator = false
        view.delegate = delegate
        view.dataSource = delegate
        
        return view
    }
    
    static func makeBannerCarousel(delegate: UICollectionViewDelegate & UICollectionViewDataSource) -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: Layout.screenWidth * 0.6, height: Layout.screenWidth * 0.25)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = delegate
        collectionView.dataSource = delegate
        
        return collectionView
    }
    
}
