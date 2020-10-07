//
//  CompaniesAutoUpdateController.swift
//  Companies
//
//  Created by William Yeung on 10/6/20.
//

import UIKit

class CompaniesAutoUpdateController: UITableViewController {
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Helpers
    func configureUI() {
        tableView.backgroundColor = .darkBlue
        setupNavBarStyle(withTitle: "Title")
    }
}
