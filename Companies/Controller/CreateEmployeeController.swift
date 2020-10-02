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
    private let birthdayLabel = UILabel.createBasicLabel(withText: "Birthday")
    private let birthdayTextfield = UITextField.createBasicTextField(withPlaceholder: "MM/dd/yyyy")
    
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
        
        let nameBackGroundView = setupNameBackgroundView(withHeightMultipleOf: 0.065 * 2)
        view.addSubviews(nameLabel, nameTextfield, birthdayLabel, birthdayTextfield)
        
        nameLabel.setDimension(height: nameBackGroundView.heightAnchor, hMult: 0.5)
        nameLabel.center(to: nameBackGroundView, by: .centerX, withMultiplierOf: 0.18)
        nameLabel.anchor(top: nameBackGroundView.topAnchor)
        
        nameTextfield.center(to: nameLabel, by: .centerY)
        nameTextfield.setDimension(width: nameBackGroundView.widthAnchor, wMult: 0.68)
        nameTextfield.center(to: nameBackGroundView, by: .centerX, withMultiplierOf: 1.25)
        
        birthdayLabel.setDimension(height: nameBackGroundView.heightAnchor, hMult: 0.5)
        birthdayLabel.anchor(left: nameLabel.leftAnchor)
        birthdayLabel.anchor(top: nameLabel.bottomAnchor)
        
        birthdayTextfield.center(to: birthdayLabel, by: .centerY)
        birthdayTextfield.setDimension(width: nameBackGroundView.widthAnchor, wMult: 0.68)
        birthdayTextfield.center(to: nameBackGroundView, by: .centerX, withMultiplierOf: 1.25)
    }
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Bad Date", message: "Birthday date entered not valid", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func cofigureBirthdate() -> Date? {
        guard let date = birthdayTextfield.text else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        if let formattedDate = dateFormatter.date(from: date) {
            return formattedDate
        } else {
            showErrorAlert()
            return nil
        }
    }
    
    // MARK: - Selectors
    @objc func handleSave() {
        guard let employeeName = nameTextfield.text, !employeeName.isEmpty else { return }
        guard let company = company else { return }
        guard let birthDate = cofigureBirthdate() else { return }
        let tuple = CoreDataManager.shared.createEmployee(withName: employeeName, birthdate: birthDate, andCompany: company)
        
        if let error = tuple.1 {
            print(error.localizedDescription)
        } else if let employee = tuple.0 {
            dismiss(animated: true) {
                self.delegate?.didAddEmployee(employee: employee)
            }
        }
    }
}
