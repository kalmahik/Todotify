//
//  ContentView.swift
//  Todotify
//
//  Created by kalmahik on 17.06.2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext: ModelContext

    var body: some View {
        let store = Store.shared
        let viewModel = TodoListViewModel(store: store)
        TodoList(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
}
