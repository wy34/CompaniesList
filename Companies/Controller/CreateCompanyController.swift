//
//  CreateCompanyController.swift
//  Companies
//
//  Created by William Yeung on 9/26/20.
//

import UIKit
import CoreData

protocol CreateCompanyControllerDelegate: class {
    func didAddCompany(company: Company)
    func didUpdateCompany(company: Company)
}

class CreateCompanyController: UIViewController {
    // MARK: - Properties
    var companyToEdit: Company? {
        didSet {
            guard let company = companyToEdit else { return }
            nameTextfield.text = company.name
        }
    }
    
    weak var delegate: CreateCompanyControllerDelegate?
    
    private let nameBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightBlue
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        return label
    }()
    
    private let nameTextfield: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter name"
        return tf
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavBar()
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = self.companyToEdit != nil ? "Edit Company" : "Create Company"
    }
    
    // MARK: - Helpers
    private func configNavBar() {
        setupNavBarStyle(withTitle: "Create Company")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    private func configUI() {
        view.backgroundColor = .darkBlue
        
        view.addSubview(nameBackgroundView)
        nameBackgroundView.anchor(top: view.topAnchor, right: view.rightAnchor, left: view.leftAnchor)
        nameBackgroundView.setDimension(hConst: 50)
        
        nameBackgroundView.addSubviews(nameLabel, nameTextfield)
        
        nameLabel.center(to: nameBackgroundView, by: .centerY)
        nameLabel.center(to: nameBackgroundView, by: .centerX, withMultiplierOf: 0.18)
        nameTextfield.center(to: nameLabel, by: .centerY)
        nameTextfield.setDimension(width: nameBackgroundView.widthAnchor, wMult: 0.68)
        nameTextfield.center(to: nameBackgroundView, by: .centerX, withMultiplierOf: 1.25)
    }
    
    private func createNewCompany()  {
        guard let companyName = nameTextfield.text, !companyName.isEmpty else { return }
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        company.setValue(companyName, forKey: "name")
        CoreDataManager.shared.save()
        dismiss(animated: true) { self.delegate?.didAddCompany(company: company as! Company) }
    }
    
    private func updateCompany() {
        guard let newName = nameTextfield.text else { return }
        companyToEdit!.name = newName
        CoreDataManager.shared.save()
        dismiss(animated: true) { self.delegate?.didUpdateCompany(company: self.companyToEdit!) }
    }
    
    
    // MARK: - Selector
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }

    @objc func handleSave() {
        if companyToEdit != nil {
            updateCompany()
        } else {
            createNewCompany()
        }
    }
}
