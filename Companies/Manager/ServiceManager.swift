//
//  ServiceManager.swift
//  Companies
//
//  Created by William Yeung on 10/7/20.
//

import Foundation

class ServiceManager {
    static let shared = ServiceManager()
        
    func decode(completion: @escaping ([JSONCompany]?) -> Void) {
        let urlString = "https://api.letsbuildthatapp.com/intermediate_training/companies"
        
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error)
                    completion(nil)
                }
                
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    let companies = try? jsonDecoder.decode([JSONCompany].self, from: data)
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
