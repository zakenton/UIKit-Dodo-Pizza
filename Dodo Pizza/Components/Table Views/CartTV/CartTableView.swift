import UIKit
import SnapKit

protocol ICartTableViewDelegate: AnyObject {
    func didTapIncrementQuantity(for cartId: UUID)
    func didTapDecrementQuantity(for cartId: UUID)
    func didTapDeleteProduct(with cartId: UUID)
    func didTapChangeButton(for product: ProductCart)
}

final class CartTableView: UITableView {
    
    weak var view: ICartTableViewDelegate?
    
    private var products: [ProductCart] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchProducts(with products: [ProductCart]) {
        self.products = products
        reloadData()
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
        view?.didTapIncrementQuantity(for: cartId)
    }
    
    func didTapDecrementQuantity(for cartId: UUID) {
        view?.didTapDecrementQuantity(for: cartId)
    }
    
    func didTapDeleteProduct(with cartId: UUID) {
        view?.didTapDeleteProduct(with: cartId)
    }
    
    func didTapChangeButton(for product: ProductCart) {
        view?.didTapChangeButton(for: product)
    }
}

// MARK: - DataSource / Delegate
extension CartTableView: UITableViewDataSource, UITableViewDelegate {
    
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
