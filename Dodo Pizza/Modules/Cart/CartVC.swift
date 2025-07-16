//
//  CartVC.swift
//  Dodo Pizza
//
//  Created by Zakhar on 03.07.25.
//

import Foundation
import UIKit

class CartVC: UIViewController {
    
    lazy var tableView = CartTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    
}

//MARK: - Setup
extension CartVC {
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
