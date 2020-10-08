//
//  EmployeesController+UITableViewController.swift
//  Companies
//
//  Created by William Yeung on 10/1/20.
//

import UIKit

extension EmployeesController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allEmployees.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = IndentedLabel()
        label.backgroundColor = .lightBlue
        label.textColor = .darkBlue
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = employeeTypes[section]
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEmployees[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let employee = allEmployees[indexPath.section][indexPath.row]
        if let employeeInformation = employee.employeeInformation {
            let dateString = stringifyDate(employeeInformation.birthday!)
            cell.textLabel?.text = "\(employee.name ?? "") \(dateString)"
        }
        cell.backgroundColor = .tealColor
        cell.textLabel?.textColor = .white
        return cell
    }
}

