//
//  UICollectionView + dequeueCell.swift
//  dodo-base
//
//  Created by Artur on 04.11.2024.
//

import UIKit

extension UICollectionViewCell: Reusable{}

extension Reusable where Self: UICollectionViewCell {
  
  static var reuseId: String {
    String(describing: self)
  }
}

extension UICollectionView {
  
    //Cell -> абстратный тип -> UICollectionViewCell
  func registerCell<Cell: UICollectionViewCell>(_ cellClass: Cell.Type) {
    register(cellClass, forCellWithReuseIdentifier: cellClass.reuseId)
  }
    
    //Cell -> конкретный тип -> BannerCollectionCell
  func dequeueCell<Cell: UICollectionViewCell>(_ indexPath: IndexPath) -> Cell {
    guard let cell = dequeueReusableCell(withReuseIdentifier: Cell.reuseId, for: indexPath) as? Cell else { fatalError("Fatal error for cell at \(indexPath)") }
    return cell
  }
}
