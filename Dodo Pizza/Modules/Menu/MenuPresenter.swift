protocol IMenuPresenterInput: AnyObject {
    func getProducts(by category: CategoryView)
    func getBanners()
    func getCategories()
    func didSelectProduct(_ product: ProductView)
    func saveProduct(_ product: ProductView)
}

protocol IMenuInteractorOutput: AnyObject {
    func didGetProducts(_ products: [ProductView])
    func didGetBanners(_ products: [ProductView])
    func didGetCategories(_ categories: [CategoryView])
}

final class MenuPresenter {
    
    weak var menuVC: IMenuVCInput?
    
    private let interactor: IMenuInteractorInput
    private let router: IRouter
    
    init(interactor: MenuInteractor, router: IRouter) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: Input
extension MenuPresenter: IMenuPresenterInput {
    func getProducts(by category: CategoryView) {
        interactor.getProducts(by: category)
    }
    
    func getBanners() {
        interactor.getBanners()
    }
    
    func getCategories() {
        interactor.getCategories()
    }
    
    func didSelectProduct(_ product: ProductView) {
        router.showDitailView(with: product)
    }
    
    func saveProduct(_ product: ProductView) {
        interactor.saveProduct(product)
    }
}

// MARK: Output
extension MenuPresenter: IMenuInteractorOutput {
    func didGetProducts(_ products: [ProductView]) {
        menuVC?.showProducts(products)
    }
    
    func didGetBanners(_ products: [ProductView]) {
        menuVC?.showBanners(products)
    }
    
    func didGetCategories(_ categories: [CategoryView]) {
        menuVC?.showCategories(categories)
    }
}
