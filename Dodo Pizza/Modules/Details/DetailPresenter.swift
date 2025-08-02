//
//  DetailPresenter.swift
//  Dodo Pizza
//
//  Created by Zakhar on 06.07.25.
//

import Foundation

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
        print("Presenter viewDidLoad")
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
