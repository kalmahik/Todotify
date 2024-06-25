//
//  TodoList.swift
//  Todotify
//
//  Created by kalmahik on 17.06.2024.
//

import SwiftUI

struct TodoList: View {
    @StateObject private var viewModel = FileCache()
    
    @State private var selectedTodo: TodoItem?
    @State private var isModalPresented = false
    
    var body: some View {
        NavigationSplitView {
            List(viewModel.todos) { todo in
                Button(action: {
                    selectedTodo = todo
                    isModalPresented = true
                }) {
                    TodoRow(todo: todo)
                }
                
            }
            .navigationTitle("Todos")
            
            Button(role: .destructive, action: { isModalPresented = true }) {
                Text("Add")
                    .frame(maxWidth: .infinity)
            }
            .frame(height: 56)
            .border(Color.black)
            
        } detail: {
            Text("Select a todo")
        }
        .sheet(isPresented: $isModalPresented, onDismiss: { selectedTodo = nil }) {
            TodoDetail(todo: selectedTodo, isPresented: $isModalPresented, viewModel: viewModel)
        }
    }
}

#Preview {
    TodoList()
}
