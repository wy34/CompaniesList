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
        configNavBar()
        configUI()
    }
    
    // MARK: - Helpers
    func configNavBar() {
        setupNavBarStyle(withTitle: "Create Employee")
        setupCancleButtonInNavBar()
    }
    
    func configUI() {
        view.backgroundColor = .darkBlue
    }
}
