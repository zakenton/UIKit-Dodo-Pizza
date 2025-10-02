import UIKit

protocol ICartVCInput: AnyObject {
    func setupTableView(with product: [ProductCart])
    func setupBottomView(with price: String)
    func showEmptyView()
    func showTableView()
}

class CartVC: UIViewController {
    
    private let presenter: ICartPresenterInput
    
    private lazy var tableView = CartTableView()
    private lazy var bottomView = CartBottomView()
    private lazy var emptyView = EmptyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getAllProducts()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getAllProducts()
    }
    
    init(presenter: ICartPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        tableView.view = self
        bottomView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CartVC: ICartVCInput {
    func setupTableView(with products: [ProductCart]) {
        tableView.fetchProducts(with: products)
    }
    
    func setupBottomView(with price: String) {
        bottomView.setTotalPrice(price)
    }
    
    func showEmptyView() {
        emptyView.isHidden = false
        tableView.isHidden = true
        bottomView.isHidden = true
    }
    
    func showTableView() {
        emptyView.isHidden = true
        tableView.isHidden = false
        bottomView.isHidden = false
    }
    
}

extension CartVC: ICartTableViewDelegate, ICartBottomViewDelegate {
    func didTapIncrementQuantity(for cartId: UUID) {
        presenter.incrementProductQuantity(for: cartId)
    }
    
    func didTapDecrementQuantity(for cartId: UUID) {
        presenter.decrementProductQuantity(for: cartId)
    }
    
    func didTapDeleteProduct(with cartId: UUID) {
        presenter.removeProduct(with: cartId)
    }
    
    func didTapChangeButton(for product: ProductCart) {
        presenter.addAdditionalProduct(product)
    }
    
    func didTapCheckout() {
        presenter.checkout()
    }
}

//MARK: - Setup
private extension CartVC {
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(bottomView)
        
        view.addSubview(emptyView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(bottomView.snp.top)
        }
    
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(Layout.screenHeight * 0.1)
        }
    
        emptyView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
