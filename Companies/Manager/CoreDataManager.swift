//
//  CoreDataManager.swift
//  Companies
//
//  Created by William Yeung on 9/27/20.
//

import Foundation
import CoreData

struct CoreDataManager {
    // MARK: - Properties
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CompanyDataModel")
        
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed: \(err)")
            }
        }
        
        return container
    }()
    
    // MARK: - Crud Methods
    func save() {
        do {
            try persistentContainer.viewContext.save()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func delete(_ company: Company) {
        persistentContainer.viewContext.delete(company)
        save()
    }
    
    func fetchCompanies() -> [Company] {
        let request: NSFetchRequest<Company> = Company.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(request)
        } catch let err {
            print(err.localizedDescription)
            return []
        }
    }
    
    func batchDeleteCompanies() {
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
        
        do {
            try persistentContainer.viewContext.execute(batchDeleteRequest)
        } catch let deleteError {
            print(deleteError.localizedDescription)
        }
    }
    
    func createEmployee(withName name: String, andCompany company: Company) -> (Employee?, Error?) {
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: persistentContainer.viewContext)
        employee.setValue(name, forKey: "name")
        employee.setValue(company, forKey: "company")
        
        do {
            try persistentContainer.viewContext.save()
            return (employee as? Employee, nil)
        } catch let err {
            print(err.localizedDescription)
            return (nil, err)
        }
    }
    
//    func fetchEmployees(forCompany company: Company) -> [Employee]? {
//        let request: NSFetchRequest<Employee> = Employee.fetchRequest()
//
//        do {
//            return try persistentContainer.viewContext.fetch(request)
//        } catch let err {
//            print(err.localizedDescription)
//            return []
//        }
//    }
}
