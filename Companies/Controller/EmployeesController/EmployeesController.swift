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
    
    var employees = [Employee]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        fetchEmployees()
        configureTableView(withCellClass: UITableViewCell.self, andReuseId: "cell")
    }
    
    // MARK: - Helpers
    private func configUI() {
        view.backgroundColor = .darkBlue
        setupAddButtonInNavBar(withSelector: #selector(handleAdd))
    }
    
    private func fetchEmployees() {
        guard let company = company, let employees = company.employees?.allObjects as? [Employee] else { return }
        self.employees = employees
    }
    
    // MARK: - Selectors
    @objc private func handleAdd() {
        let createEmployeeController = CreateEmployeeController()
        createEmployeeController.delegate = self
        createEmployeeController.company = company
        let navController = CustomNavigationController(rootViewController: createEmployeeController)
        present(navController, animated: true, completion: nil)
    }
}
