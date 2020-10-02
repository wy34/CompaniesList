//
//  CreateEmployeeController.swift
//  Companies
//
//  Created by William Yeung on 9/30/20.
//

import UIKit

class CreateEmployeeController: UIViewController {
    // MARK: - Properties
    private let nameLabel = UILabel.createBasicLabel(withText: "Name")
    private let nameTextfield = UITextField.createBasicTextField(withPlaceholder: "Enter name")
    
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    func configUI() {
        view.backgroundColor = .darkBlue
        
        let nameBackGroundView = setupNameBackgroundView(withHeightMultipleOf: 0.065)
        view.addSubviews(nameLabel, nameTextfield)
        
        nameLabel.setDimension(height: nameBackGroundView.heightAnchor, hMult: 0.3)
        nameLabel.center(to: nameBackGroundView, by: .centerX, withMultiplierOf: 0.18)
        nameLabel.center(to: nameBackGroundView, by: .centerY)
        
        nameTextfield.center(to: nameLabel, by: .centerY)
        nameTextfield.setDimension(width: nameBackGroundView.widthAnchor, wMult: 0.68)
        nameTextfield.center(to: nameBackGroundView, by: .centerX, withMultiplierOf: 1.25)
    }
    
    // MARK: - Selectors
    @objc func handleSave() {
        guard let employeeName = nameTextfield.text, !employeeName.isEmpty else { return }
        let error = CoreDataManager.shared.createEmployee(withName: employeeName)
        
        if let error = error {
            
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}
