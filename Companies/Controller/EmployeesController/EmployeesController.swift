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
    
    var shortNameEmployees = [Employee]()
    var longNameEmployees = [Employee]()
    var reallyLongNameEmployees = [Employee]()
    var allEmployees = [[Employee]]()
    
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
    
    func fetchEmployees() {
        guard let company = company, let employees = company.employees?.allObjects as? [Employee] else { return }
        
        shortNameEmployees = employees.filter {
            if let name = $0.name {
                return name.count < 6
            }
            return false
        }
        
        longNameEmployees = employees.filter {
            if let name = $0.name {
                return name.count > 6 && name.count < 9
            }
            return false
        }
        
        reallyLongNameEmployees = employees.filter {
            if let name = $0.name {
                return name.count > 9
            }
            return false
        }
        
        allEmployees = [shortNameEmployees, longNameEmployees, reallyLongNameEmployees]
    }
    
    func stringifyDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return dateFormatter.string(from: date)
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
