//
//  EmployeeTarget.swift
//  EmployeeApp
//
//  Created by Ichsan Indra Wahyudi on 10/10/24.
//

import Foundation
import Moya

enum EmployeeTarget {
    case getEmployees(type: ResultType)
}

extension EmployeeTarget: TargetType {
    var baseURL: URL {
        switch self {
        case let .getEmployees(type):
            switch type {
            case .empty:
                return URL(string: Constants.EMPTY_API_URL)!
            case .success:
                return URL(string: Constants.SUCCESS_API_URL)!
            case .error:
                return URL(string: Constants.ERROR_API_URL)!
            }
        }
    }
    
    var path: String {
        return ""
    }
    
    var method: Moya.Method {
        return .get
    }
    
    private var parameters: [String: Any] {
        return [:]
    }
    
    var task: Moya.Task {
        return .requestParameters(
            parameters: parameters,
            encoding: method == .get ? URLEncoding.default : JSONEncoding.default
        )
    }
    
    var headers: [String : String]? {
        [:]
    }
}

