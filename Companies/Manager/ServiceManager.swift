//
//  ServiceManager.swift
//  Companies
//
//  Created by William Yeung on 10/7/20.
//

import Foundation
import CoreData

class ServiceManager {
    static let shared = ServiceManager()
        
    func decode() {
        let urlString = "https://api.letsbuildthatapp.com/intermediate_training/companies"
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error)
                    return 
                }
                
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    let companies = try? jsonDecoder.decode([JSONCompany].self, from: data)
                    let backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                    backgroundContext.parent = CoreDataManager.shared.persistentContainer.viewContext
                    
                    companies?.forEach({ (jsonCompany) in
                        let company = Company(context: backgroundContext)
                        company.name = jsonCompany.name
                        
                        let formatter = DateFormatter()
                        formatter.dateFormat = "MM/dd/yyyy"
                        let foundedDate = formatter.date(from: jsonCompany.founded)
                        company.founded = foundedDate
                        
                        do {
                            try backgroundContext.save()
                            try backgroundContext.parent?.save()
                        } catch let err {
                            print(err)
                        }
                    })
                }
            }.resume()
        }
    }
}


struct JSONCompany: Decodable {
    let name: String
    let founded: String
    let employees: [JSONEmployee]?
}

struct JSONEmployee: Decodable {
    let name: String
    let birthday: String
    let type: String
}
