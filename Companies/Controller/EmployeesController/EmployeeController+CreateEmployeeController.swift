//
//  EmployeeController+CreateEmployeeController.swift
//  Companies
//
//  Created by William Yeung on 10/1/20.
//

import UIKit

extension EmployeesController: CreateEmployeeControllerDelegate {
    func didAddEmployee(employee: Employee) {
        guard let section = employeeTypes.firstIndex(of: employee.type!) else { return }
        let row = allEmployees[section].count
        let indexPath = IndexPath(row: row, section: section)
        allEmployees[section].append(employee)
        tableView.insertRows(at: [indexPath], with: .middle)
    }
}
