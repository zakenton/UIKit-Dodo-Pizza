import Foundation
import UIKit

extension UITableViewCell: Reusable {}

extension UITableView {
    
    func registerCell<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseId)
    }
    
    func dequeueCell<Cell: UITableViewCell>(_ indexPath: IndexPath) -> Cell {
        guard let cell = self.dequeueReusableCell(withIdentifier: Cell.reuseId, for: indexPath) as? Cell
        else {fatalError("Fatal error for cell at \(indexPath)")}
        return cell
    }
}

extension Reusable where Self: UITableViewCell {
    
    static var reuseId: String {
        return String(describing: self)
    }
}
