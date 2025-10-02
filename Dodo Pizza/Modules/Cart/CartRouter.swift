import Foundation
import UIKit


final class CartRouter {
    weak var cartVC: CartVC?
    weak var cartPresenter: ICartPresenterInput?
}

extension CartRouter: IRouter {
    func saveProduct(_ product: IProductDisplayable) {
        cartPresenter?.saveAdditedProduct(product as! ProductCart)
    }
    
    func showDitailView(with product: IProductDisplayable) {
        let detailsVC = DetailAssembly.build(product: product, router: self)
        cartVC?.present(detailsVC, animated: true)
    }
}
