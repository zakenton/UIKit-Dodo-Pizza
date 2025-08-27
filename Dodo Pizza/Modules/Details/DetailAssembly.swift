//
//  DetailBuilder.swift
//  Dodo Pizza
//
//  Created by Zakhar on 06.07.25.
//

import Foundation
import UIKit

final class DetailAssembly {
    
    static func build(product: IProductDisplayable, router: IRouter) -> DetailsVC {
        let router = DetailRouter(router: router)
        
        let interactor = DetailInteractor(product: product)
        
        let presenter = DetailPresenter(interactor: interactor, router: router)
        let view = DetailsVC(presenter: presenter)
        
        
        router.detailsVC = view
        presenter.detailVC = view
        interactor.presenter = presenter
        
        return view
    }
}
