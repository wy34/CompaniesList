//
//  CompaniesAutoUpdateController.swift
//  Companies
//
//  Created by William Yeung on 10/6/20.
//

import UIKit
import CoreData

class CompaniesAutoUpdateController: UITableViewController {
    // MARK: - Properties
    let fetchedResultsController: NSFetchedResultsController<Company> = {
        let request: NSFetchRequest<Company> = Company.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try frc.performFetch()
        } catch let err {
            print(err)
        }
        
        return frc
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableview()
        configureUI()
    }
    
    // MARK: - Helpers
    func configureTableview() {
        tableView.backgroundColor = .darkBlue
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }
    
    func configureUI() {
        setupNavBarStyle(withTitle: "Company Auto Updates")
    }
}

// MARK: - UITableViewDelegate/Datasource
extension CompaniesAutoUpdateController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        return cell
    }
}
