//
//  ViewController.swift
//  Companies
//
//  Created by William Yeung on 9/26/20.
//

import UIKit

class HomeController: UITableViewController {
    // MARK: - Properties

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
        newAppearance.backgroundColor = UIColor(red: 247/255, green: 66/255, blue: 82/255, alpha: 1)

        navigationController?.navigationBar.scrollEdgeAppearance = newAppearance
        navigationController?.navigationBar.standardAppearance = newAppearance
        navigationController?.navigationBar.compactAppearance = newAppearance
        
        title = "Companies"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
    }
    
    func configureTableView() {
        tableView.backgroundColor = UIColor(red: 9/255, green: 45/255, blue: 64/255, alpha: 1)
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
        return 8
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.backgroundColor = UIColor(red: 48/255, green: 164/255, blue: 182/255, alpha: 1)
        return cell
    }
}
