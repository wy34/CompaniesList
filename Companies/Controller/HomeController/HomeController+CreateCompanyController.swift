//
//  HomeController+CreateCompany.swift
//  Companies
//
//  Created by William Yeung on 9/30/20.
//

import UIKit

extension HomeController: CreateCompanyControllerDelegate {
    func didUpdateCompany(company: Company) {
        guard let row = companies.firstIndex(of: company) else { return }
        let indexPath = IndexPath(row: row, section: 0)
        tableView.reloadRows(at: [indexPath], with: .middle)
    }
    
    func didAddCompany(company: Company) {
        companies.append(company)
        tableView.insertRows(at: [IndexPath(row: companies.count - 1, section: 0)], with: .automatic)
    }
}
