//
//  MapTableView.swift
//  Dodo Pizza
//
//  Created by Zakhar on 20.07.25.
//

import UIKit
import SnapKit

final class MapTableView: UITableView {
    
    private var userAddress: [Address] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        delegate = self
        dataSource = self
        registerCell(MapTableViewCell.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MapTableView: UITableViewDelegate {
    func fetchAddress(with userAddress: [Address]) {
        self.userAddress = userAddress
    }
}

extension MapTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userAddress.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(indexPath) as MapTableViewCell
        cell.configure(address: userAddress[indexPath.row])
        return cell
    }
}

