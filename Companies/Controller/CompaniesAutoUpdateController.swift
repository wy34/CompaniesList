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
    lazy var fetchedResultsController: NSFetchedResultsController<Company> = {
        let request: NSFetchRequest<Company> = Company.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        
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
        configureTableView(withCellClass: CompanyCell.self, andReuseId: "cellId")
        configureUI()
    }
    
    // MARK: - Helpers
    func configureUI() {
        setupNavBarStyle(withTitle: "Company Auto Updates")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(handleAdd))
    }
    
    // MARK: - Selectors
    @objc private func handleAdd() {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let company = Company(context: context)
        company.name = "ZZZ"
        CoreDataManager.shared.save()
    }
}

// MARK: - UITableViewDelegate/Datasource
extension CompaniesAutoUpdateController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CompanyCell
        let company = fetchedResultsController.object(at: indexPath)
        cell.company = company
        return cell
    }
}

// MARK: - NSFetchedResultsControllerDelegate
extension CompaniesAutoUpdateController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .move:
            if let indexPath = indexPath, let newIndexPath = newIndexPath {
                tableView.moveRow(at: indexPath, to: newIndexPath)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        @unknown default:
            break
        }
    }
}
