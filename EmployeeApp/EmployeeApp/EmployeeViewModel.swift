//
//  EmployeeViewModel.swift
//  EmployeeApp
//
//  Created by Ichsan Indra Wahyudi on 10/10/24.
//

import Foundation
import Combine

class EmployeeViewModel: ObservableObject {
    @Published var state: ViewState<[Employee]> = .loading
    @Published var selectedType: EmployeeType = .all

    private var employees: [Employee] = []
    private let employeeService: EmployeeServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    var filteredEmployees: [Employee] {
        guard case .success = state, selectedType != .all else { return employees }
        return employees.filter { $0.type == selectedType }
    }
    
    init(employeeService: EmployeeServiceProtocol = EmployeeService()) {
        self.employeeService = employeeService
    }

    func fetchData(type: ResultType, isLoading: Bool = false) {
        if isLoading {
            state = .loading
        }
        
        employeeService.getEmployee(type)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    self?.state = .error(error.localizedDescription)
                }
            }, receiveValue: {  [weak self] data in
                if data.employees.isEmpty {
                    self?.state = .empty
                } else {
                    self?.employees = data.employees
                    self?.state = .success(self?.filteredEmployees ?? [])
                }
            })
            .store(in: &cancellables)
    }
    
    func setSelectedType(_ type: EmployeeType) {        
        selectedType = type
        
        state = employees.isEmpty ? .empty : .success(filteredEmployees)
    }
}

// Helper

enum ViewState<T> {
    case loading
    case empty
    case success(T)
    case error(String)
}
