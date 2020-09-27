//
//  ViewController.swift
//  Companies
//
//  Created by William Yeung on 9/26/20.
//

import UIKit

class HomeController: UITableViewController {
    // MARK: - Properties
    let companies = [
        Company(name: "Apple", founded: Date()),
        Company(name: "Google", founded: Date()),
        Company(name: "Facebook", founded: Date())
    ]

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureTableView()
    }

    // MARK: - Helpers
    func configureNavBar() {
        let newAppearance = UINavigationBarAppearance()
        newAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        newAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        newAppearance.backgroundColor = .lightRed

        navigationController?.navigationBar.scrollEdgeAppearance = newAppearance
        navigationController?.navigationBar.standardAppearance = newAppearance
        navigationController?.navigationBar.compactAppearance = newAppearance
        
        title = "Companies"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
    }
    
    func configureTableView() {
        tableView.backgroundColor = .darkBlue
        tableView.separatorColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Selectors
    @objc func handleAddCompany() {
        print("Adding company...")
    }
}

// MARK: - UITableViewDelegate/Datasource
extension HomeController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = .tealColor
        cell.textLabel?.text = companies[indexPath.row].name
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        cell.textLabel?.textColor = .white
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
}
