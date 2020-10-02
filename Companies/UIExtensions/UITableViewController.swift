//
//  UITableViewController.swift
//  Companies
//
//  Created by William Yeung on 10/1/20.
//

import UIKit

extension UITableViewController {
    func configureTableView(withCellClass cellClass: AnyClass, andReuseId reuseId: String) {
        tableView.backgroundColor = .darkBlue
        tableView.separatorColor = .white
        tableView.register(cellClass, forCellReuseIdentifier: reuseId)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 60
    }
}
