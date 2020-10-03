//
//  EmployeeController+CreateEmployeeController.swift
//  Companies
//
//  Created by William Yeung on 10/1/20.
//

import UIKit

extension EmployeesController: CreateEmployeeControllerDelegate {
    func didAddEmployee(employee: Employee) {
        fetchEmployees()
        tableView.reloadData()
    }
}
