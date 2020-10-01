//
//  HomeController+UITableViewController.swift
//  Companies
//
//  Created by William Yeung on 9/30/20.
//

import UIKit

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


