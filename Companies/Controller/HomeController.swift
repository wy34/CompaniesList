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
    
    private func edit(company: Company) {
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

// MARK: - UITableViewDelegate/Datasource
extension HomeController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CompanyCell.reuseId, for: indexPath) as! CompanyCell
        let company = companies[indexPath.row]
        cell.company = company
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlue
        return view
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "No companies available..."
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return companies.count > 0 ? 0 : 150
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let companyToEditDelete = self.companies[indexPath.row]
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
            self.edit(company: companyToEditDelete)
            completion(true)
        }
        editAction.backgroundColor = .darkBlue
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            self.companies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            CoreDataManager.shared.delete(companyToEditDelete)
            completion(true)
        }
        deleteAction.backgroundColor = .lightRed
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}

// MARK: - CreateCompanyControllerDelegate
extension HomeController: CreateCompanyControllerDelegate {
    func didUpdateCompany(company: Company) {
        guard let row = companies.firstIndex(of: company) else { return }
        let indexPath = IndexPath(row: row, section: 0)
        tableView.reloadRows(at: [indexPath], with: .middle)
    }
    
    func didAddCompany(company: Company) {
        companies.append(company)
        tableView.insertRows(at: [IndexPath(row: companies.count - 1, section: 0)], with: .automatic)
    }
}
