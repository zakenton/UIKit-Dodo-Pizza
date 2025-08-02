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
    // MARK: - Properties
    weak var presenter: ICartPresenterInput?
    
    private var products: [ProductCart] = [] {
        didSet {
            reloadData()
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        delegate = self
        dataSource = self
        registerCell(CartTableViewCell.self)
    }
}

// MARK: - Cell Delegate
extension CartTableView: ICartTableViewCellDelegate {
    func didTapIncrementQuantity(for cartId: UUID) {
        presenter?.incrementProductQuantity(for: cartId)
    }
    
    func didTapDecrementQuantity(for cartId: UUID) {
        presenter?.decrementProductQuantity(for: cartId)
    }
    
    func didTapDeleteProduct(with cartId: UUID) {
        presenter?.removeProduct(with: cartId)
    }
    
    func didTapChangeButton(for product: ProductCart) {
        presenter?.addAdditionalProduct(product)
    }
}

// MARK: - UITableViewDelegate
extension CartTableView: UITableViewDelegate {
    func updateProducts(_ products: [ProductCart]) {
        self.products = products
    }
}

// MARK: - UITableViewDataSource
extension CartTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as CartTableViewCell
        cell.configure(with: products[indexPath.row])
        cell.delegate = self
        return cell
    }
}
