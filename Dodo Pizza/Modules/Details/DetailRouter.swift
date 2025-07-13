//
//  DetailRouter.swift
//  Dodo Pizza
//
//  Created by Zakhar on 06.07.25.
//

import Foundation
import UIKit

final class DetailRouter {
    weak var detailsVC: DetailsVC?
}

extension DetailRouter: IDetailRouterInput {
    
    func closeDetails() {
        detailsVC?.dismiss(animated: true)
    }
}
