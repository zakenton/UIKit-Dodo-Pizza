//
//  ProductsTableView.swift
//  Dodo Pizza
//
//  Created by Zakhar on 13.07.25.
//

import UIKit
import SnapKit

protocol ProductTableViewDelegate: AnyObject {
    func didSelectCategory()
    func didSelectProduct(product: ProductView)
}
// oeifeojf
final class ProductsTableView: UIView {
    
    
    
    private var products: [ProductView] = []
    private var categories: [CategoryView] = []
    private var selectedCategory: CategoryView = .pizza
    
    lazy var categoriesCarousel = CategoryCarouselHeader()
    
    weak var delegate: ProductTableViewDelegate?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        return tableView
    }()
}
// MARK: Input
extension ProductsTableView {
    
    func fethcCategories(with categories: [CategoryView]) {
        self.categories = categories
    }
    
    func setCurrentCategory() {
        
    }
    
    func fetchProducts(with products: [ProductView]) {
        self.products = products
        tableView.reloadData()
    }
}

extension ProductsTableView: ProductCellDelegate {
    
    func didTapPriceButton(for product: ProductView) {
        delegate?.didSelectProduct(product: product)
    }
}

// MARK: - TableView Delegate
extension ProductsTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}



// MARK: - TableView DataSource
extension ProductsTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return categoriesCarousel
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as ProductCell
        cell.update(with: products[indexPath.row])
        cell.delegate = self
        return cell
    }
}
