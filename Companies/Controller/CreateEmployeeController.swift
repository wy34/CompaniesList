//
//  CreateEmployeeController.swift
//  Companies
//
//  Created by William Yeung on 9/30/20.
//

import UIKit

class CreateEmployeeController: UIViewController {
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarStyle(withTitle: "Create Employee")
        configUI()
    }
    
    // MARK: - Helpers
    func configUI() {
        view.backgroundColor = .darkBlue
    }
}
