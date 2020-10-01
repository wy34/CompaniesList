//
//  EmployeesController.swift
//  Companies
//
//  Created by William Yeung on 9/30/20.
//

import UIKit

class EmployeesController: UITableViewController {
    // MARK: - Properties
    var company: Company? {
        didSet {
            guard let company = company else { return }
            title = company.name
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkBlue
    }
}
