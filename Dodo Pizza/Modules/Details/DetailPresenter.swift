import Foundation

protocol IDetailPresenterInput: AnyObject {
    func viewDidLoad()
    
    func didSelectDough(index: Int)
    func didSelectSize(index: Int)
    func didSelectAdditive(index: Int)
    
    func didTapAddToCart()
    func didTapCloseButton()
}

protocol IDetailInteractorOutput: AnyObject {
    func didSetupView(imageURL: String,
                      description: String,
                      dough: [ProductOption]?,
                      options: [ProductOption]?,
                      additives: [ProductAdditiveView]?,
                      price: Double)
    
    func didСhangedOption(price: Double)
    func didSetAdditive(index: Int, isSelected: Bool)
    func didSaveProduct(_ product: IProductDisplayable)
    func didErrorSavingProduct()
}

final class DetailPresenter {
    weak var detailVC: DetailsVC?
    private let interactor: IDetailInteractorInput?
    private let router: IDetailRouterInput?
    
    init(interactor: IDetailInteractorInput?, router: IDetailRouterInput?) {
        self.interactor = interactor
        self.router = router
    }
}

// MARK: Private Logic
private extension DetailPresenter {
    
}

// MARK: Input
extension DetailPresenter: IDetailPresenterInput {
    func didTapCloseButton() {
        router?.closeDetails()
    }
    
    func viewDidLoad() {
        interactor?.setupView()
    }
    
    func didSelectSize(index: Int) {
        interactor?.setSelectedOption(index: index)
    }
    
    func didSelectDough(index: Int) {
        interactor?.setSelectedDough(index: index)
    }
    
    func didSelectAdditive(index: Int) {
        interactor?.setSelectedAdditive(index: index)
    }
    
    func didTapAddToCart() {
        interactor?.saveProductToCart()
    }
}

// MARK: Output
extension DetailPresenter: IDetailInteractorOutput {
    func didSetupView(imageURL: String,
                      description: String,
                      dough: [ProductOption]?,
                      options: [ProductOption]?,
                      additives: [ProductAdditiveView]?,
                      price: Double) {

        detailVC?.setImage(imageURL: imageURL)
        detailVC?.setDescription(description: description)
        
        if let dough = dough {
            detailVC?.setDough(option: dough)
        }
        
        if let options = options {
            detailVC?.setSize(option: options)
        }
        
        if let additives = additives {
            detailVC?.setAdditives(option: additives)
        }
        
        detailVC?.setPrice(price: price)
    }
    
    
    func didСhangedOption(price: Double) {
        detailVC?.setPrice(price: price)
    }
    
    func didSetAdditive(index: Int, isSelected: Bool) {
        detailVC?.updateAdditive(at: index, isSelected: isSelected)
    }
    
    func didSaveProduct(_ product: any IProductDisplayable) {
        router?.routeProductToSave(product)
    }
    
    func didErrorSavingProduct() {
        
    }
}
