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
    private let birthdayTextfield = UITextField.createBasicTextField(withPlaceholder: "mm/dd/yyyy")
    
    private let employeeTypeSegmentedControll: UISegmentedControl = {
        let types = ["Executive", "Senior Managment", "Staff"]
        let sc = UISegmentedControl(items: types)
        sc.selectedSegmentIndex = 0
        sc.tintColor = .darkBlue
        return sc
    }()
    
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
        
        let nameBackGroundView = setupNameBackgroundView(withHeightMultipleOf: 0.065 * 3)
        view.addSubviews(nameLabel, nameTextfield, birthdayLabel, birthdayTextfield, employeeTypeSegmentedControll)
        
        nameLabel.setDimension(height: nameBackGroundView.heightAnchor, hMult: 0.333)
        nameLabel.anchor(left: nameBackGroundView.leftAnchor, paddingLeft: 20)
        nameLabel.anchor(top: nameBackGroundView.topAnchor)
        
        nameTextfield.center(to: nameLabel, by: .centerY)
        nameTextfield.setDimension(width: nameBackGroundView.widthAnchor, wMult: 0.68)
        nameTextfield.anchor(right: nameBackGroundView.rightAnchor, paddingRight: 25)
        
        birthdayLabel.setDimension(height: nameBackGroundView.heightAnchor, hMult: 0.333)
        birthdayLabel.anchor(left: nameLabel.leftAnchor)
        birthdayLabel.anchor(top: nameLabel.bottomAnchor)
        
        birthdayTextfield.center(to: birthdayLabel, by: .centerY)
        birthdayTextfield.setDimension(width: nameTextfield.widthAnchor)
        birthdayTextfield.anchor(right: nameTextfield.rightAnchor)
        
        employeeTypeSegmentedControll.anchor(top: birthdayLabel.bottomAnchor, right: birthdayTextfield.rightAnchor, left: birthdayLabel.leftAnchor)
    }
    
    func showErrorAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
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
            showErrorAlert(withTitle: "Date Error", andMessage: "Birthdate is missing or formatted incorrectly!")
            return nil
        }
    }
    
    // MARK: - Selectors
    @objc func handleSave() {
        guard let employeeName = nameTextfield.text, !employeeName.isEmpty else {
            showErrorAlert(withTitle: "Name Error", andMessage: "Please fill in a name.")
            return
        }
        guard let company = company else { return }
        guard let birthDate = cofigureBirthdate() else { return }
        guard let type = employeeTypeSegmentedControll.titleForSegment(at: employeeTypeSegmentedControll.selectedSegmentIndex) else { return }
        let tuple = CoreDataManager.shared.createEmployee(withName: employeeName, birthdate: birthDate, type: type, andCompany: company)
        
        if let error = tuple.1 {
            print(error.localizedDescription)
        } else if let employee = tuple.0 {
            dismiss(animated: true) {
                self.delegate?.didAddEmployee(employee: employee)
            }
        }
    }
}
