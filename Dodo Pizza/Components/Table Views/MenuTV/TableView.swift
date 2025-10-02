import Foundation
import UIKit

final class TableViewFactory {
    
    static func makeMenuTableView(delegate: UITableViewDelegate & UITableViewDataSource) -> UITableView {
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = delegate
        tableView.dataSource = delegate
        tableView.separatorStyle = .none
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
        return tableView
    }
}
