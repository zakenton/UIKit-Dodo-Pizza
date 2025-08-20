//
//  AccountView.swift
//  Dodo Pizza
//
//  Created by Zakhar on 20.08.25.
//

import Foundation
import UIKit
import SnapKit

final class AccountView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        let label = UILabel()
        label.text = "Здесь меню"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
