//
//  MenuTableView.swift
//  Dodo Pizza
//
//  Created by Zakhar on 30.09.25.
//

import UIKit
final class MenuTableView: UITableView {
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

// MARK: - Sections
enum MenuTableViewSections: Int, CaseIterable {
    case topBar
    case banner
    case productList
}

// MARK: - Cell Delegate
extension MenuTableView {
    
}

// MARK: - UITableViewDelegate
extension MenuTableView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { MenuCells.allCases.count }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let s = MenuCells(rawValue: section) else { return 0 }
        switch s {
        case .topBar: return 1
        case .banner: return 1
        case .productList: return products.count
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let s = MenuCells(rawValue: section) else { return 0 }
        switch s {
        case .topBar, .banner: return 0
        case .productList: return 40
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let s = MenuCells(rawValue: section) else { return nil }
        switch s {
        case .topBar, .banner: return nil
        case .productList: return categoriesCarousel
        }
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let s = MenuCells(rawValue: indexPath.section) else { return UITableViewCell() }
        switch s {
        case .topBar:
            let cell: TopBarCell = tableView.dequeueCell(indexPath)
            cell.delegate = self
            return cell
        case .banner:
            let cell: BannerCell = tableView.dequeueCell(indexPath)
            cell.setCarousel(with: banners)
            return cell
        case .productList:
            let cell: ProductCell = tableView.dequeueCell(indexPath)
            cell.update(with: products[indexPath.row])
            cell.delegate = self
            return cell
        }
    }
}

