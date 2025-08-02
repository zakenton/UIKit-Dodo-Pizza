//
//  CartVC.swift
//  Dodo Pizza
//
//  Created by Zakhar on 03.07.25.
//

import Foundation
import UIKit

class CartVC: UIViewController {
    
    private let presenter: ICartPresenterInput
    
    lazy var tableView = CartTableView()
    lazy var bottomView = CartBottomView()
    lazy var emptyView = EmptyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.getAllProducts()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getAllProducts()
    }
    
    init(presenter: ICartPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Setup
extension CartVC {
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(bottomView)
        
        view.addSubview(emptyView)
        tableView.presenter = presenter
    }
    
    func showEmptyView() {
        emptyView.isHidden = false
        tableView.isHidden = true
    }
    
    func showTableView() {
        emptyView.isHidden = true
        tableView.isHidden = false
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.left.right.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(bottomView.snp.top)
        }
    
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(Layout.screenHeight * 0.1)
        }
    
        emptyView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
