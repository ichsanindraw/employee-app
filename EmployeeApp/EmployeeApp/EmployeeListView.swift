//
//  EmployeeListView.swift
//  EmployeeApp
//
//  Created by Ichsan Indra Wahyudi on 10/10/24.
//

import SwiftUI
import Kingfisher

struct EmployeeListView: View {
    @StateObject private var viewModel = EmployeeViewModel()
    @State private var showFilterType = false
    @State private var showMockResultSheet = false

    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .loading:
                    VStack {
                        ProgressView()
                    }
                    
                case .empty:
                    ContentUnavailableView(label: {
                        Text("Empty Data")
                    }, description: {
                        Text("There is no employee data record")
                    })
                    
                case let .success(data):
                    List(data) { employee in
                        EmployeeRowView(employee: employee)
                    }
                    .refreshable {
                        viewModel.fetchData(type: .success)
                    }
                    
                case let .error(text):
                    ContentUnavailableView(label: {
                        Text("Error")
                    }, description: {
                        Text(text)
                    }, actions: {
                        Button(action: {
                            viewModel.fetchData(type: .success, isLoading: true)
                        }, label: {
                            Text("Try Again")
                        })
                    })
                }
            }
            .navigationTitle("Employees")
            .onAppear {
                viewModel.fetchData(type: .success)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        showMockResultSheet = true
                    }) {
                        Image(systemName: "gear")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showFilterType = true
                    }) {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                    }
                }
            }
            .actionSheet(isPresented: $showMockResultSheet) {
                ActionSheet(
                    title: Text("Mock Result"),
                    buttons: [
                        .default(Text("Success")) {
                            viewModel.fetchData(type: .success, isLoading: true)
                        },
                        .default(Text("Empty")) {
                            viewModel.fetchData(type: .empty, isLoading: true)
                        },
                        .default(Text("Error")) {
                            viewModel.fetchData(type: .error, isLoading: true)
                        },
                        .cancel()
                    ]
                )
            }
            .sheet(isPresented: $showFilterType, content: {
                FilterMenuView<EmployeeType>(
                    items: EmployeeType.allCases,
                    labelKeyPath: \.value,
                    title: "Filter Employee",
                    selectedItem: viewModel.selectedType,
                    onSelect: { type in
                        viewModel.setSelectedType(type)
                    }
                )
            })
        }
    }
}

struct EmployeeRowView: View {
    let employee: Employee

    var body: some View {
        HStack {
            if let url = URL(string: employee.photo) {
                KFImage(url)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            } else {
                Circle()
                    .fill(Color.gray)
                    .frame(width: 50, height: 50)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Text(employee.fullName)
                        .font(.headline)
                    Spacer()
            
                    Text(employee.type.value)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(5)
                        .background(employee.type.color.opacity(0.2))
                        .cornerRadius(8)
                }
                
                Text(employee.team)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                HStack {
                    Image(systemName: "phone.fill")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.gray)
                    Text(employee.phone)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Image(systemName: "envelope.fill")
                        .resizable()
                        .frame(width: 12, height: 10)
                        .foregroundColor(.gray)
                    Text(employee.email)
                        .font(.footnote)
                        .foregroundColor(.blue)
                }
                
                Text(employee.biography)
                    .font(.footnote)
                    .lineLimit(2)
                    .foregroundColor(.gray)
            }
        }
    }
}

extension EmployeeType {
    var value: String {
        switch self {
        case .fullTime:
            return "Full Time"
        case .partTime:
            return "Part Time"
        case .contractor:
            return "Contractor"
        case .all:
            return "All Employee"
        }
    }
    
    var color: Color {
        switch self {
        case .fullTime:
            return Color.blue
        case .partTime:
            return Color.green
        case .contractor:
            return Color.red
        case .all:
            return Color.clear
        }
    }
}
