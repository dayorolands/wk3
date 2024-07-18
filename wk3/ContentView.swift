//
//  ContentView.swift
//  wk3
//
//  Created by Dayo Adekoya on 7/17/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var context
    @State private var isShowingItemSheet = false
    @Query(sort: \Expense.date) var expenses: [Expense]
    @State private var expenseToEdit: Expense?
    
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    
    private let offsetValue : CGFloat = -60
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses) { expense in
                    ExpenseCell(expense: expense)
                        .onTapGesture {
                            expenseToEdit = expense
                        }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        do {
                            try context.delete(expenses[index])
                        } catch {
                            errorMessage = "Failed to delete expense, please try again."
                            showErrorAlert = true
                            return
                        }
                    }
                }
            }
            .navigationTitle("Expenses")
            .navigationBarTitleDisplayMode(.large)
            .sheet(isPresented: $isShowingItemSheet, content: {
                AddExpenseSheet()
            })
            .sheet(item: $expenseToEdit, content: { expense in
                UpdateExpenseSheet(expense: expense)
            })
            .toolbar {
                if !expenses.isEmpty {
                    Button("Add Expense", systemImage: "plus") {
                        isShowingItemSheet = true
                    }
                }
            }
            .overlay {
                if expenses.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No Expenses", systemImage: "list.bullet.rectangle.portrait")
                    }, description: {
                        Text("Start adding expenses to your list.")
                    }, actions: {
                        Button("Add Expense") {
                            isShowingItemSheet = true
                        }
                    })
                    .offset(y: offsetValue)
                }
            }
            .alert(isPresented: $showErrorAlert, content: {
                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            })
        }
    }
}

#Preview {
    ContentView()
}
