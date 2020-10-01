//
//  ViewController.swift
//  Companies
//
//  Created by William Yeung on 9/26/20.
//

import UIKit
import CoreData

class HomeController: UITableViewController {
    // MARK: - Properties
    var companies = [Company]()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureTableView()
        fetchCompanies()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }

    // MARK: - Helpers
    private func configureNavBar() {
        setupNavBarStyle(withTitle: "Companies")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .darkBlue
        tableView.separatorColor = .white
        tableView.register(CompanyCell.self, forCellReuseIdentifier: CompanyCell.reuseId)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 60
    }
    
    private func fetchCompanies() {
        self.companies = CoreDataManager.shared.fetchCompanies()
    }
    
    private func goToCreateCompanyController(withCompany company: Company? = nil) {
        let createCompanyController = CreateCompanyController()
        createCompanyController.delegate = self
        
        if let company = company {
            createCompanyController.companyToEdit = company
        }
        
        let navController = CustomNavigationController(rootViewController: createCompanyController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    func edit(company: Company) {
        goToCreateCompanyController(withCompany: company)
    }
        
    // MARK: - Selectors
    @objc private func handleAddCompany() {
        goToCreateCompanyController()
    }
    
    @objc private func handleReset() {
        CoreDataManager.shared.batchDeleteCompanies()
        
        var indexPaths = [IndexPath]()
        
        for (index, _) in companies.enumerated() {
            let indexPath = IndexPath(row: index, section: 0)
            indexPaths.append(indexPath)
        }
        
        companies.removeAll()
        tableView.deleteRows(at: indexPaths, with: .left)
    }
}

