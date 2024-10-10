//
//  EmployeeService.swift
//  EmployeeApp
//
//  Created by Ichsan Indra Wahyudi on 10/10/24.
//

import Combine
import Foundation

protocol EmployeeServiceProtocol {
    func getEmployee(_ type: ResultType) -> AnyPublisher<EmployeeResponse, NetworkError>
}

class EmployeeService: EmployeeServiceProtocol {
    private let networkManager: NetworkManager<EmployeeTarget>
    
    init(networkManager: NetworkManager<EmployeeTarget> = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getEmployee(_ type: ResultType) -> AnyPublisher<EmployeeResponse, NetworkError> {
        networkManager.request(.getEmployees(type: type), EmployeeResponse.self)
    }
}
