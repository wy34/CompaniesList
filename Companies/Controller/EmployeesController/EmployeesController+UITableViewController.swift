//
//  EmployeesController+UITableViewController.swift
//  Companies
//
//  Created by William Yeung on 10/1/20.
//

import UIKit

extension EmployeesController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let employee = employees[indexPath.row]
        let dateString = stringifyDate(employee.employeeInformation!.birthday!)
        cell.textLabel?.text = "\(employee.name ?? "") \(dateString)"
        cell.backgroundColor = .tealColor
        cell.textLabel?.textColor = .white
        return cell
    }
}
