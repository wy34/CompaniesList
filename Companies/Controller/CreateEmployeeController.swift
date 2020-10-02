//
//  CreateEmployeeController.swift
//  Companies
//
//  Created by William Yeung on 9/30/20.
//

import UIKit

protocol CreateEmployeeControllerDelegate: class {
    func didAddEmployee(employee: Employee)
}

class CreateEmployeeController: UIViewController {
    // MARK: - Properties
    weak var delegate: CreateEmployeeControllerDelegate?
    var company: Company?
    
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
        setupSaveButtonInNavBar(withSelector: #selector(handleSave))
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
        guard let company = company else { return }
        let tuple = CoreDataManager.shared.createEmployee(withName: employeeName, andCompany: company)
        
        if let error = tuple.1 {
            print(error.localizedDescription)
        } else if let employee = tuple.0 {
            dismiss(animated: true) {
                self.delegate?.didAddEmployee(employee: employee)
            }
        }
    }
}
