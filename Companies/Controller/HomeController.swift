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
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .darkBlue
        tableView.separatorColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.tableFooterView = UIView()
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
    @objc func handleAddCompany() {
        goToCreateCompanyController()
    }
}

// MARK: - UITableViewDelegate/Datasource
extension HomeController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let company = companies[indexPath.row]
        guard let name = company.name, let founded = company.founded else { return UITableViewCell() }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, yyyy"
        let foundedDateString = dateFormatter.string(from: founded)
        cell.backgroundColor = .tealColor
        cell.textLabel?.text = "\(name) - Founded \(foundedDateString)"
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        cell.textLabel?.textColor = .white
        
        if let imageData = company.image {
            cell.imageView?.image = UIImage(data: imageData)
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlue
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
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
