import UIKit
import SnapKit

protocol IMenuVCInput: AnyObject {
    func showProducts(_ products: [ProductView])
    func showBanners(_ banners: [ProductView])
    func showCategories(_ categories: [CategoryView])
}

final class MenuVC: UIViewController {

    // MARK: - Account
    private var accountVC: AccountView!
    private var isAccountVisible = false
    private let accountWidth: CGFloat = 300
    private var accountRightConstraint: Constraint?
    

    // MARK: - UI
    private let categoriesCarousel = CategoryCarouselHeader()
    private lazy var tableView = TableViewFactory.makeMenuTableView(delegate: self)

    // MARK: - Dimming
    private let dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.alpha = 0
        view.isHidden = true
        view.isUserInteractionEnabled = true
        return view
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

// MARK: - Delegates (From cell)
extension MenuVC: ProductCellDelegate, TopBarCellDelegate {
    
    //TODO: AccountView
    func openAccountView() {
        toggleAccount()
    }
    
    func didTapPriceButton(for product: ProductView) {
        presenter.didSelectProduct(product)
    }
}

// MARK: - Sections
enum MenuCells: Int, CaseIterable {
    case topBar
    case banner
    case productList
}

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
        // content
        view.addSubview(tableView)
        // Dimming block interection when account view is open
        view.addSubview(dimmingView)

        // AccountVC
        accountVC = AccountView()
        addChild(accountVC)
        view.addSubview(accountVC.view)
        accountVC.didMove(toParent: self)

        //tableView -> dimming -> account
        view.bringSubviewToFront(dimmingView)
        view.bringSubviewToFront(accountVC.view)
        
        //close after tap on dimming
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapDimming))
        dimmingView.addGestureRecognizer(tap)

        //swipe on account view to close
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handleAccountPan(_:)))
        pan.cancelsTouchesInView = true
        accountVC.view.addGestureRecognizer(pan)

        //TODO: close using button
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

        // accountVC — (trailing = +accountWidth)
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
        ///Block Interaction with main View
        tableView.isUserInteractionEnabled = false
        ///Dimmint for main View
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
        ///Exept interaction with main View
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

    // Swipe on menu to close
    @objc func handleAccountPan(_ g: UIPanGestureRecognizer) {
        let translation = g.translation(in: view)
        let dx = max(0, translation.x)
        
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

    //open AccountVC from right slide
    @objc func handleEdgeOpen(_ g: UIScreenEdgePanGestureRecognizer) {
        switch g.state {
        case .began:
            if !isAccountVisible {
                dimmingView.isHidden = false
            }
        case .changed:
            let dx = -g.translation(in: view).x
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

// MARK: - AccountView Protocol
protocol AccountClosable {
    var onClose: (() -> Void)? { get set }
}
