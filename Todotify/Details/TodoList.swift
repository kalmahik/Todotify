//
//  TodoList.swift
//  Todotify
//
//  Created by kalmahik on 17.06.2024.
//

import SwiftUI

struct TodoList: View {
    @StateObject private var todoDetailModel = FileCache()
    
    @State private var isCreationModalPresented = false
    @State private var isEditionModalPresented = false
    
    var body: some View {
        NavigationSplitView {
            List(todoDetailModel.todos) { todoItem in
                Button(action: { isEditionModalPresented = true }) {
                    TodoRow(todo: todoItem)
                }
                .sheet(isPresented: $isEditionModalPresented) {
                    TodoDetail(
                        viewModel: TodoDetailViewModel(todoItem: todoItem, todoDetailModel: todoDetailModel),
                        isPresented: $isEditionModalPresented
                    )
                }
            }
            .navigationTitle("Мои дела")
            
            Button(role: .destructive, action: { isCreationModalPresented = true }) {
                Text("Add")
                    .frame(maxWidth: .infinity)
            }
            .frame(height: 56)
            .border(Color.black)
            
        } detail: {
            Text("Select a todo")
        }
        .sheet(isPresented: $isCreationModalPresented) {
            TodoDetail(viewModel: TodoDetailViewModel(todoItem: nil, todoDetailModel: todoDetailModel), isPresented: $isCreationModalPresented)
        }
    }
}

#Preview {
    TodoList()
}
