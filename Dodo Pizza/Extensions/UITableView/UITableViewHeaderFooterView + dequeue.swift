//
//  UITableViewHeaderFooterView + dequeue.swift
//  dodo-pizza-work
//
//  Created by Zakhar on 29.06.25.
//

import Foundation
import UIKit

protocol Reusable {}

extension UITableView {
    
    func registerHeaderFooterView<View: UITableViewHeaderFooterView>(_ viewClass: View.Type) {
        register(viewClass, forHeaderFooterViewReuseIdentifier: viewClass.reuseId)
    }
    
    func dequeueHeader<View: UITableViewHeaderFooterView>() -> View {
        guard let view = self.dequeueReusableHeaderFooterView(withIdentifier: View.reuseId) as? View
        else { fatalError("Fatal error for cell at \(String(describing: indexPath))") }
        return view
    }
}

extension UITableViewHeaderFooterView: Reusable {}

extension Reusable where Self: UITableViewHeaderFooterView {
    static var reuseId: String {
        String(describing: self)
    }
}
