//
//  ViewController.swift
//  Companies
//
//  Created by William Yeung on 9/26/20.
//

import UIKit

class HomeController: UIViewController {
    // MARK: - Properties

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
    }

    // MARK: - Helpers
    func configureNavBar() {
        let newAppearance = UINavigationBarAppearance()
        newAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        newAppearance.backgroundColor = UIColor(red: 247/255, green: 66/255, blue: 82/255, alpha: 1)
        
        navigationController?.navigationBar.scrollEdgeAppearance = newAppearance
        navigationController?.navigationBar.standardAppearance = newAppearance
        navigationController?.navigationBar.compactAppearance = newAppearance
        
        title = "Companies"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleAddCompany))
    }
    
    // MARK: - Selectors
    @objc func handleAddCompany() {
        print("Adding company...")
    }
}

