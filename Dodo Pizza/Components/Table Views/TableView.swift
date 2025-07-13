//
//  TableView.swift
//  dodo-pizza-work
//
//  Created by Zakhar on 29.06.25.
//

import Foundation
import UIKit

final class TableViewFactory {
    
    static func makeMenuTableView(delegate: UITableViewDelegate & UITableViewDataSource) -> UITableView {
        
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = delegate
        tableView.dataSource = delegate
        tableView.separatorStyle = .none
        return tableView
    }
}
