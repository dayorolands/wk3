//
//  wk3App.swift
//  wk3
//
//  Created by Dayo Adekoya on 7/17/24.
//

import SwiftUI
import SwiftData

@main
struct wk3App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Expense.self])
    }
}
