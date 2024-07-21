//
//  UpdateExpenseSheet.swift
//  wk3
//
//  Created by Dayo Adekoya on 7/18/24.
//

import SwiftUI

struct UpdateExpenseSheet: View {
    @Environment(\.dismiss) private var dismss
    @Environment(\.modelContext) private var context

    @Bindable var expense: Expense
    var body: some View {
        NavigationStack {
            Form {
                TextField("Expense Name", text: $expense.name)
                DatePicker("Date", selection: $expense.date, displayedComponents: .date)
                TextField("Value", value: $expense.value, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Update Expense")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing, content: {
                    Button("Done") {
                        dismss()
                    }
                })
            }
        }
    }
}

