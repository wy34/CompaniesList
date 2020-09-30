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
            datePicker.date = company.founded!
            
            if let imageData = company.image {
                profileImage.image = UIImage(data: imageData)
            }
        }
    }
    
    weak var delegate: CreateCompanyControllerDelegate?
    
    private let nameBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightBlue
        return view
    }()
    
    private lazy var profileImage: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "select")
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleImageSelectorTapped)))
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = (UIScreen.main.bounds.width * 0.25) / 2
        iv.layer.borderWidth = 2
        iv.layer.borderColor = UIColor.darkBlue.cgColor
        return iv
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
    
    private let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.preferredDatePickerStyle = .wheels
        dp.datePickerMode = .date
        return dp
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
        nameBackgroundView.setDimension(height: view.heightAnchor, hMult: 0.5)
        
        nameBackgroundView.addSubviews(profileImage, nameLabel, nameTextfield, datePicker)
        
        profileImage.center(to: nameBackgroundView, by: .centerX)
        profileImage.center(to: nameBackgroundView, by: .centerY, withMultiplierOf: 0.35)
        profileImage.setDimension(width: nameBackgroundView.widthAnchor, height: nameBackgroundView.widthAnchor, wMult: 0.25, hMult: 0.25)
    
        nameLabel.anchor(top: profileImage.bottomAnchor)
        nameLabel.setDimension(height: nameBackgroundView.heightAnchor, hMult: 0.2)
        nameLabel.center(to: nameBackgroundView, by: .centerX, withMultiplierOf: 0.18)
        
        nameTextfield.center(to: nameLabel, by: .centerY)
        nameTextfield.setDimension(width: nameBackgroundView.widthAnchor, wMult: 0.68)
        nameTextfield.center(to: nameBackgroundView, by: .centerX, withMultiplierOf: 1.25)
        
        datePicker.anchor(top: nameLabel.bottomAnchor, right: nameBackgroundView.rightAnchor, bottom: nameBackgroundView.bottomAnchor, left: nameBackgroundView.leftAnchor)
    }
    
    private func createNewCompany()  {
        guard let companyName = nameTextfield.text, !companyName.isEmpty else { return }
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let company = NSEntityDescription.insertNewObject(forEntityName: "Company", into: context)
        company.setValue(companyName, forKey: "name")
        company.setValue(datePicker.date, forKey: "founded")
        
        if let imageData = profileImage.image?.jpegData(compressionQuality: 0.8) {
            company.setValue(imageData, forKey: "image")
        }
        
        CoreDataManager.shared.save()
        dismiss(animated: true) { self.delegate?.didAddCompany(company: company as! Company) }
    }
    
    private func updateCompany() {
        guard let newName = nameTextfield.text, !newName.isEmpty else { return }
        companyToEdit!.name = newName
        companyToEdit?.founded = datePicker.date
        companyToEdit?.image = profileImage.image?.jpegData(compressionQuality: 0.8)
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
    
    @objc func handleImageSelectorTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate
extension CreateCompanyController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        profileImage.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}
