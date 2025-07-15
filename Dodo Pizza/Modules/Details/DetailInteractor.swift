//
//  DetailInteractor.swift
//  Dodo Pizza
//
//  Created by Zakhar on 06.07.25.
//

import Foundation

final class DetailInteractor {
    weak var presenter: IDetailInteractorOutput?
    
    private let cartService: ICartServiseInput
    
    private var product: IProductDisplayable

    init(cartService: ICartServiseInput, product: IProductDisplayable) {
        self.cartService = cartService
        self.product = product
    }
}

// MARK: - Private Logic
private extension DetailInteractor {
    
    func setDough(index: Int) {
        guard product.dough != nil else { return }
        
        for i in 0..<product.dough!.count {
            product.dough![i].isSelected = (i == index)
        }
    }
    
    func setOption(index: Int) {
        guard product.size != nil else { return }
        
        for i in 0..<product.size!.count {
            product.size![i].isSelected = (i == index)
        }
    }
    
    func toggleAdditive(at index: Int) {
        guard let additives = product.additive, additives.indices.contains(index) else { return }

        product.additive![index].isSelected.toggle()
        print("Toggle")
    }
    
    func countTotalPrice() -> Double {
        let doughPrice = product.dough?.first(where: { $0.isSelected })?.price ?? 0
        let optionPrice = product.size?.first(where: { $0.isSelected })?.price ?? 0
        let additivesPrice = product.additive?
                .filter { $0.isSelected }
                .map { $0.price }
                .reduce(0, +) ?? 0
        
        return product.price + doughPrice + optionPrice + additivesPrice
    }
}

// MARK: Input
extension DetailInteractor: IDetailInteractorInput {
    func setupView() {
        print("Set Peoduct")
        presenter?.didSetupView(imageURL: product.imageURL,
                                description: product.description,
                                dough: product.dough,
                                options: product.size,
                                additives: product.additive,
                                price: countTotalPrice())
    }
    
    func setSelectedDough(index: Int) {
        setDough(index: index)
        let totalPrice = countTotalPrice()
        presenter?.didСhangedOption(price: totalPrice)
    }
    
    func setSelectedOption(index: Int) {
        setOption(index: index)
        let totalPrice = countTotalPrice()
        presenter?.didСhangedOption(price: totalPrice)
    }
    
    func setSelectedAdditive(index: Int) {
        toggleAdditive(at: index)
        
        let totalPrice = countTotalPrice()
        presenter?.didСhangedOption(price: totalPrice)
        
        if let isSelected = product.additive?[index].isSelected {
            presenter?.didSetAdditive(index: index, isSelected: isSelected)
        }
    }
    
    func saveProductToCart() {
        print("Saved")
        presenter?.didSaveProduct()
    }
}

