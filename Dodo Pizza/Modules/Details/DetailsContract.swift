//
//  DetailsContract.swift
//  Dodo Pizza
//
//  Created by Zakhar on 06.07.25.
//

import Foundation
import UIKit

protocol IDetailViewInput: AnyObject {
    func setImage(imageURL: String)
    func setDescription(description: String)
    func setDough(option: [ProductOption])
    func setSize(option: [ProductOption])
    func setAdditives(option: [ProductAdditiveView])
    func setPrice(price: Double)
}

protocol IDetailViewOutput: AnyObject {
    func didChangeOption(option: ProductOption)
    func didTapAddToCart()
    func didTapCloseButton()
}

protocol IDetailPresenterInput: AnyObject {
    func viewDidLoad()
    
    func didSelectDough(index: Int)
    func didSelectSize(index: Int)
    func didSelectAdditive(index: Int)
    
    func didTapAddToCart()
    func didTapCloseButton()
}

protocol IDetailInteractorInput: AnyObject {
    func setupView()
    func setSelectedDough(index: Int)
    func setSelectedOption(index: Int)
    func setSelectedAdditive(index: Int)
    func saveProductToCart()
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
    func didSaveProduct()
    func didErrorSavingProduct()
}

protocol IDetailRouterInput: AnyObject {
    func closeDetails()
}
