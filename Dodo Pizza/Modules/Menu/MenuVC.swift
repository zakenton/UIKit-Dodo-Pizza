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
    
    private var banners: [ProductView] = []
    private var products: [ProductView] = []
    private var categories: [CategoryView] = []
    private var selectedCategory: CategoryView = .pizza
    
    private var presenter: IMenuPresenterInput
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraint()
        registerCell()
        presenter.viewDidLoad()
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
        self.products = products
        tableView.reloadData()
    }
    
    func showBanners(_ banners: [ProductView]) {
        self.banners = banners
        updateTableHeader()
    }
    
    func showCategories(_ categories: [CategoryView], selectedCategory: CategoryView) {
        self.categories = categories
        self.selectedCategory = selectedCategory
        updateCategoriesCarousel()
    }
    
    func selectCategory(_ products: [ProductView], selectedCategory: CategoryView) {
        self.products = products
        self.selectedCategory = selectedCategory
        updateCategoriesCarousel()
        tableView.reloadData()
    }
}

// MARK: - View Output
extension MenuVC: ProductCellDelegate {
    func didTapPriceButton(for product: ProductView) {
        presenter.didSelectProduct(product)
    }
}



// MARK: - TableView Delegate
extension MenuVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

// MARK: - TableView DataSource
extension MenuVC: UITableViewDataSource {
    
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

// MARK: - Setup View
private extension MenuVC {
    
    func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        setupTableHeader()
        setupCategoriesCarousel()
    }
    
    func setupConstraint() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func registerCell() {
        tableView.registerCell(ProductCell.self)
    }
    
    // MARK: TableHeader
    func setupTableHeader() {
        let container = UIView()
        
        let topBar = TopBarView()
        let bannerLabel = BannerLabelView()
        bannerLabel.setText("Bestsellers")
        let bannersCarousel = BannerCarouselView()
        
        container.addSubview(topBar)
        container.addSubview(bannerLabel)
        container.addSubview(bannersCarousel)
        
        topBar.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
        
        bannerLabel.snp.makeConstraints { make in
            make.top.equalTo(topBar.snp.bottom).offset(Layout.offset6)
            make.left.right.equalToSuperview()
        }
        
        bannersCarousel.snp.makeConstraints { make in
            make.top.equalTo(bannerLabel.snp.bottom).offset(Layout.offset6)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(150)
        }
        
        container.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 250)
        tableView.tableHeaderView = container
    }
    
    func setupCategoriesCarousel() {
        categoriesCarousel.update(categories: categories, selectedCategory: selectedCategory)
        categoriesCarousel.onCategorySelect = { [weak self ] category in
            self?.presenter.didSelectCategory(category)
        }
    }
    
    func updateTableHeader() {
        if let headerView = tableView.tableHeaderView {
            for subview in headerView.subviews {
                if let bannersCarousel = subview as? BannerCarouselView {
                    bannersCarousel.update(with: banners)
                }
            }
        }
    }
    
    func updateCategoriesCarousel() {
        categoriesCarousel.update(categories: categories, selectedCategory: selectedCategory)
    }
}
