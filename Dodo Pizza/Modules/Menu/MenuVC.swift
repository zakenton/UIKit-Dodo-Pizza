//
//  MenuVC.swift
//  dodo-pizza-project-final
//
//  Created by Zakhar on 29.06.25.
//
import UIKit
import SnapKit

final class MenuVC: UIViewController {

    // MARK: - Account
    private var accountVC: AccountView!
    private var isAccountVisible = false
    private let accountWidth: CGFloat = 300
    private var accountRightConstraint: Constraint? // SnapKit constraint

    // MARK: - UI (контент меню)
    private let categoriesCarousel = CategoryCarouselHeader()
    private lazy var tableView = TableViewFactory.makeMenuTableView(delegate: self)

    // MARK: - Dimming поверх контента MenuVC (под AccountView)
    private let dimmingView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        v.alpha = 0
        v.isHidden = true
        v.isUserInteractionEnabled = true // ловит тап для закрытия
        return v
    }()

    // MARK: - Data
    private var products: [ProductView] = []
    private var banners: [ProductView] = []

    // MARK: - Presenter
    private let presenter: IMenuPresenterInput

    // MARK: - Init
    init(presenter: IMenuPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        registerCells()
        setupGestures()

        presenter.getBanners()
        presenter.getCategories()
    }
}

// MARK: - View Input
extension MenuVC: IMenuVCInput {
    func showProducts(_ products: [ProductView]) {
        self.products = products
        tableView.reloadSections(IndexSet(integer: MenuCells.productList.rawValue), with: .fade)
    }

    func showBanners(_ banners: [ProductView]) {
        self.banners = banners
        tableView.reloadSections(IndexSet(integer: MenuCells.banner.rawValue), with: .fade)
    }

    func showCategories(_ categories: [CategoryView]) {
        categoriesCarousel.fetchCategoies(categories: categories)
        categoriesCarousel.onCategorySelect = { [weak self] category in
            self?.presenter.getProducts(by: category)
        }
        presenter.getProducts(by: categoriesCarousel.selectedCategory)
    }
}

// MARK: - Delegates (из ячеек)
extension MenuVC: ProductCellDelegate, TopBarCellDelegate {
    func openAccountView() { toggleAccount() }
    func didTapPriceButton(for product: ProductView) {
        presenter.didSelectProduct(product)
    }
}

// MARK: - Sections
enum MenuCells: Int, CaseIterable { case topBar, banner, productList }

// MARK: - UITableViewDelegate/DataSource
extension MenuVC: UITableViewDelegate, UITableViewDataSource {
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

// MARK: - Setup
private extension MenuVC {
    func setupView() {
        view.backgroundColor = .systemBackground

        // Контент
        view.addSubview(tableView)

        // Dimming над контентом (будет блокировать взаимодействия с меню при открытом аккаунте)
        view.addSubview(dimmingView)

        // AccountVC как независимый элемент (добавляем только здесь)
        accountVC = AccountView()
        addChild(accountVC)
        view.addSubview(accountVC.view)
        accountVC.didMove(toParent: self)

        // Порядок слоев: tableView (низ) -> dimming (середина) -> account (верх)
        view.bringSubviewToFront(dimmingView)
        view.bringSubviewToFront(accountVC.view)

        // Закрытие по тапу на затемнение
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapDimming))
        dimmingView.addGestureRecognizer(tap)

        // Свайп по самому аккаунт-меню для интерактивного закрытия
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handleAccountPan(_:)))
        pan.cancelsTouchesInView = true
        accountVC.view.addGestureRecognizer(pan)

        // Если AccountView имеет кнопку «крестик», можно пробросить колбэк:
        if var closable = accountVC as? AccountClosable {
            closable.onClose = { [weak self] in self?.hideAccount(animated: true) }
        }
    }

    func setupConstraints() {
        // tableView
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        // dimming поверх tableView
        dimmingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // accountVC — спрятан за правым краем (trailing = +accountWidth)
        accountVC.view.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(accountWidth)
            self.accountRightConstraint = make.trailing.equalToSuperview().offset(accountWidth).constraint
        }
    }

    func registerCells() {
        tableView.registerCell(TopBarCell.self)
        tableView.registerCell(BannerCell.self)
        tableView.registerCell(ProductCell.self)
    }

    func setupGestures() {
        // Открывающий свайп с правого края экрана
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleEdgeOpen(_:)))
        edgePan.edges = .right
        view.addGestureRecognizer(edgePan)
    }
}

// MARK: - Actions
private extension MenuVC {
    @objc func didTapDimming() { hideAccount(animated: true) }

    func toggleAccount() {
        isAccountVisible ? hideAccount(animated: true) : showAccount(animated: true)
    }

    func showAccount(animated: Bool) {
        guard !isAccountVisible else { return }
        isAccountVisible = true

        // Блокируем взаимодействия с контентом MenuVC
        tableView.isUserInteractionEnabled = false

        dimmingView.isHidden = false
        accountRightConstraint?.update(offset: 0)

        let animations = {
            self.view.layoutIfNeeded()
            self.dimmingView.alpha = 1
        }
        if animated {
            UIView.animate(withDuration: 0.28,
                           delay: 0,
                           usingSpringWithDamping: 0.95,
                           initialSpringVelocity: 0.8,
                           options: .curveEaseOut,
                           animations: animations)
        } else { animations() }
    }

    func hideAccount(animated: Bool) {
        guard isAccountVisible else { return }
        isAccountVisible = false

        // Разрешаем взаимодействия с контентом MenuVC
        tableView.isUserInteractionEnabled = true

        accountRightConstraint?.update(offset: accountWidth)
        let animations = {
            self.view.layoutIfNeeded()
            self.dimmingView.alpha = 0
        }
        let completion: (Bool) -> Void = { _ in
            self.dimmingView.isHidden = true
        }
        if animated {
            UIView.animate(withDuration: 0.25,
                           delay: 0,
                           options: .curveEaseIn,
                           animations: animations,
                           completion: completion)
        } else { animations(); completion(true) }
    }

    // Свайп по самому меню (интерактивное закрытие)
    @objc func handleAccountPan(_ g: UIPanGestureRecognizer) {
        let translation = g.translation(in: view)
        let dx = max(0, translation.x) // учитываем только движение вправо (закрытие)

        switch g.state {
        case .began:
            dimmingView.isHidden = false
        case .changed:
            let clamped = min(accountWidth, dx)
            accountRightConstraint?.update(offset: clamped)
            let progress = clamped / accountWidth
            dimmingView.alpha = 1 - progress
            view.layoutIfNeeded()
        case .ended, .cancelled:
            let vx = g.velocity(in: view).x
            let shouldClose = (accountRightConstraint?.layoutConstraints.first?.constant ?? 0) > accountWidth * 0.35 || vx > 500
            shouldClose ? hideAccount(animated: true) : showAccount(animated: true)
        default: break
        }
    }

    // Открытие свайпом с правого края
    @objc func handleEdgeOpen(_ g: UIScreenEdgePanGestureRecognizer) {
        switch g.state {
        case .began:
            if !isAccountVisible {
                // подготовим состояния для интерактива открытия
                dimmingView.isHidden = false
            }
        case .changed:
            let dx = -g.translation(in: view).x // из правого края тянем влево → отрицательное
            let progress = min(max(dx / accountWidth, 0), 1)
            accountRightConstraint?.update(offset: accountWidth * (1 - progress))
            dimmingView.alpha = progress
            view.layoutIfNeeded()
        case .ended, .cancelled:
            let openEnough = dimmingView.alpha > 0.35
            openEnough ? showAccount(animated: true) : hideAccount(animated: true)
        default: break
        }
    }
}

// MARK: - Протокол для независимости AccountView (опционально)
protocol AccountClosable {
    var onClose: (() -> Void)? { get set }
}
