//
//  CreateCompanyController.swift
//  Companies
//
//  Created by William Yeung on 9/26/20.
//

import UIKit

class CreateCompanyController: UIViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavBar()
    }
    
    // MARK: - Helpers
    func configNavBar() {
        setupNavBarStyle(withTitle: "Create Company")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
    }
    
    // MARK: - Selector
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }

}
