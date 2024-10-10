//
//  Employee.swift
//  EmployeeApp
//
//  Created by Ichsan Indra Wahyudi on 10/10/24.
//

import Foundation

struct EmployeeResponse: Codable {
    let employees: [Employee]
}

struct Employee: Codable, Identifiable {
    var id: String { uuid }
    
    let uuid: String
    let fullName: String
    let phone: String
    let email: String
    let biography: String
    let photo: String
    let team: String
    let type: EmployeeType
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case fullName = "full_name"
        case phone = "phone_number"
        case email = "email_address"
        case biography
        case photo = "photo_url_small"
        case team
        case type = "employee_type"
    }
}

enum EmployeeType: String, Codable, CaseIterable {
    case all
    case fullTime = "FULL_TIME"
    case partTime = "PART_TIME"
    case contractor = "CONTRACTOR"
}

enum ResultType {
    case empty
    case success
    case error
}
