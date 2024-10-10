//
//  FilterMenuView.swift
//  EmployeeApp
//
//  Created by Ichsan Indra Wahyudi on 10/10/24.
//

import SwiftUI

struct FilterMenuView<Item: Hashable>: View {
    @Environment(\.dismiss) var dismiss
    
    let items: [Item]
    let labelKeyPath: KeyPath<Item, String>
    let title: String
    let selectedItem: Item
    let onSelect: (Item) -> Void

    var body: some View {
        NavigationView {
            List(items, id: \.self) { item in
                Button(action: {
                    onSelect(item)
                    dismiss()
                }) {
                    HStack {
                        Text(item[keyPath: labelKeyPath] )
                        Spacer()
                        if selectedItem == item {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

