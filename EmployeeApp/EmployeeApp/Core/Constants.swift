//
//  Constants.swift
//  EmployeeApp
//
//  Created by Ichsan Indra Wahyudi on 10/10/24.
//

import Foundation

struct Constants {
    static let SUCCESS_API_URL = Bundle.main.infoDictionary?["SUCCESS_API_URL"] as? String ?? ""
    static let EMPTY_API_URL = Bundle.main.infoDictionary?["EMPTY_API_URL"] as? String ?? ""
    static let ERROR_API_URL = Bundle.main.infoDictionary?["ERROR_API_URL"] as? String ?? ""
}
