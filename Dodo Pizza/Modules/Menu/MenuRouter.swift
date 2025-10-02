import Foundation
import UIKit

protocol IRouter: AnyObject {
    func showDitailView(with product: IProductDisplayable)
    func saveProduct(_ product: IProductDisplayable)
}

final class MenuRouter {
    
    weak var menuVC: MenuVC?
    weak var menuPresenter: IMenuPresenterInput?
}

extension MenuRouter: IRouter {
    func saveProduct(_ product: IProductDisplayable) {
        menuPresenter?.saveProduct(product as! ProductView)
    }
    
    func showDitailView(with product: IProductDisplayable) {
        let detailsVC = DetailAssembly.build(product: product, router: self)
        menuVC?.present(detailsVC, animated: true)
    }
}
