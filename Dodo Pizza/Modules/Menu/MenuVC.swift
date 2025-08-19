//
//  MenuVC.swift
//  dodo-pizza-project-final
//
//  Created by Zakhar on 29.06.25.
//

import Foundation
import UIKit
import SnapKit

// MARK: - Init
class MenuVC: UIViewController {
    
    private lazy var tableView = TableViewFactory.makeMenuTableView(delegate: self)
    private let categoriesCarousel = CategoryCarouselHeader()
    
    
    private var products: [ProductView] = []
    private var banners: [ProductView] = []
    
    private var presenter: IMenuPresenterInput
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraint()
        registerCell()
        
        presenter.getBanners()
        presenter.getCategories()
    }
    
    
    init(presenter: IMenuPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - View Input
extension MenuVC: IMenuVCInput {
    func showProducts(_ products: [ProductView]) {
        print(products.count)
        self.products = products
        tableView.reloadSections(IndexSet(integer: MenuCells.productList.rawValue), with: .fade)
    }
    
    func showBanners(_ banners: [ProductView]) {
        print(banners.count)
        self.banners = banners
        tableView.reloadSections(IndexSet(integer: MenuCells.banner.rawValue), with: .fade)
    }
    
    func showCategories(_ categories: [CategoryView]) {
        print(categories.count)
        categoriesCarousel.fetchCategoies(categories: categories)
        categoriesCarousel.onCategorySelect = { [weak self ] category in
            self?.presenter.getProducts(by: category)
        }
        presenter.getProducts(by: categoriesCarousel.selectedCategory)
    }
}

// MARK: - View Output
extension MenuVC: ProductCellDelegate {
    func didTapPriceButton(for product: ProductView) {
        presenter.didSelectProduct(product)
    }
}

extension MenuVC {
    
}

//MARK: Cells ENUM
enum MenuCells: Int, CaseIterable {
    case topBar
    case banner
    case productList
}

// MARK: - TableView Delegate
extension MenuVC: UITableViewDelegate {
    
    ///проблема была не в constraits TopBarView и не в кортинке внутри него
    ///по какойто причине к кажной секции добался пустой Header
    ///если выставить высоту на 0  Header вроде как полностью уходит с view
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let menuSections = MenuCells.init(rawValue: section) else {return 0}
        
        switch menuSections {
        case .topBar:
            return 0
        case .banner:
            return 0
        case .productList:
            return 40
        }
    }
}

// MARK: - TableView DataSource
extension MenuVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MenuCells.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let menuSections = MenuCells.init(rawValue: section) else {return 0}
        
        switch menuSections {
        case .topBar:
            return 1
        case .banner:
            return 1
        case .productList:
            return products.count
        }
    }
    
    // нет смысла использовать заглушку в виде пустого View
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let menuSections = MenuCells.init(rawValue: section) else {return nil}
        
        switch menuSections {
        case .topBar:
            return nil
        case .banner:
            return nil
        case .productList:
            return categoriesCarousel
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let menuSections = MenuCells.init(rawValue: indexPath.section) else {return UITableViewCell()}
        
        switch menuSections {
        case .topBar:
            let cell = tableView.dequeueCell(indexPath) as TopBarCell
            return cell
        case .banner:
            let cell = tableView.dequeueCell(indexPath) as BannerCell
            cell.setCarousel(with: banners)
            return cell
        case .productList:
            let cell = tableView.dequeueCell(indexPath) as ProductCell
            cell.update(with: products[indexPath.row])
            cell.delegate = self
            return cell
        }
    }
}

// MARK: - Setup View
private extension MenuVC {
    
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
    }
    
    func setupConstraint() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func registerCell() {
        tableView.registerCell(TopBarCell.self)
        tableView.registerCell(BannerCell.self)
        tableView.registerCell(ProductCell.self)
    }
}
