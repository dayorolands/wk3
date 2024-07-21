//
//  AddExpenseSheet.swift
//  wk3
//
//  Created by Dayo Adekoya on 7/18/24.
//

import SwiftUI

struct AddExpenseSheet: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismissView

    @State private var name: String = ""
    @State private var date: Date = .now
    @State private var value: Double = 0
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Expense Name", text: $name)
                DatePicker("Date", selection: $date, displayedComponents: .date)
                TextField("Value", value: $value, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("New Expense")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") { dismissView() }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save"){
                        saveExpense()
                    }
                }
            }
            .alert(isPresented: $showErrorAlert, content: {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            })
        }
    }
    
    private func saveExpense(){
        guard !name.isEmpty else {
            errorMessage = "Expense name cannot be empty."
            showErrorAlert = true
            return
        }
        
        guard value > 0 else {
            errorMessage = "Expense value must be greater than 0."
            showErrorAlert = true
            return
        }
        
        let expense = Expense(name: name, date: date, value: value)
        context.insert(expense)
        dismissView()
    }
}

#Preview {
    AddExpenseSheet()
}
