//
//  ContentView.swift
//  Todotify
//
//  Created by kalmahik on 17.06.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        let store = Store.shared
        let viewModel = TodoListViewModel(store: store)
        TodoList(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
}
