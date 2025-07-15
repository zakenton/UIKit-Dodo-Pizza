//
//  DetailBuilder.swift
//  Dodo Pizza
//
//  Created by Zakhar on 06.07.25.
//

import Foundation
import UIKit

final class DetailBuilder {
    
    static func build(product: IProductDisplayable, router: IMenuRouter) -> DetailsVC {
        let router = DetailRouter(router: router)
        let presenter = DetailPresenter()
        let view = DetailsVC(presenter: presenter)
        let interactor = DetailInteractor(product: product)
        
        router.detailsVC = view
        presenter.detailVC = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
}
