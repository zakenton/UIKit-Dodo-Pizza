//
//  DetailBuilder.swift
//  Dodo Pizza
//
//  Created by Zakhar on 06.07.25.
//

import Foundation
import UIKit

final class DetailBuilder {
    
    static func build(product: IProductDisplayable, cartService: ICartServiseInput) -> DetailsVC {
        let router = DetailRouter()
        let presenter = DetailPresenter()
        let view = DetailsVC(presenter: presenter)
        let interactor = DetailInteractor(cartService: cartService, product: product)
        
        router.detailsVC = view
        presenter.detailVC = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
}
