//
//  EmployeeController+CreateEmployeeController.swift
//  Companies
//
//  Created by William Yeung on 10/1/20.
//

import UIKit

extension EmployeesController: CreateEmployeeControllerDelegate {
    func didAddEmployee(employee: Employee) {
//        tableView.insertRows(at: [IndexPath(row: employees.count - 1, section: 0)], with: .automatic)
        fetchEmployees()
        tableView.reloadData()
    }
}
