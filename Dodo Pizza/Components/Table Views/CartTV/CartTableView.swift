//
//  CartTableView.swift
//  Dodo Pizza
//
//  Created by Zakhar on 16.07.25.
//

import Foundation
import UIKit
import SnapKit

final class CartTableView: UITableView {
    
    private var products: [ProductCartViewModel] = MockProductCartViewModel.products
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        delegate = self
        dataSource = self
        registerCell(CartTableViewCell.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CartTableView: UITableViewDelegate {
    
}

extension CartTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as CartTableViewCell
        cell.configure(with: products[indexPath.row])
        return cell
    }
}
