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
            ZStack(alignment: .bottom) {
                Color.background
                    .edgesIgnoringSafeArea(.all)
                
                List(todoDetailModel.todos) { todoItem in
                    let viewModel = TodoDetailViewModel(todoItem: todoItem, todoDetailModel: todoDetailModel)
                    Button(action: {
                        isEditionModalPresented = true
                    }) {
                        TodoRow(todo: todoItem)
                    }
                    .swipeActions(allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            viewModel.deleteTodo()
                        } label: {
                            Label("Удалить", systemImage: "trash.fill")
                        }
                        .tint(.red)
                        Button {
                            viewModel.deleteTodo()
                        } label: {
                            Label("Инфо", systemImage: "info.fill")
                        }
                        .tint(.gray)
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        Button {
                            viewModel.completeTodo()
                        }
                    label: { Image(systemName: "checkmark.circle") }
                    }
                    .tint(.green)
                    
                    .sheet(isPresented: $isEditionModalPresented) {
                        TodoDetail(
                            viewModel: viewModel,
                            isPresented: $isEditionModalPresented
                        )
                    }
                }
//                .listRowBackground(Color.clear)
//                .listStyle(PlainListStyle())
                .navigationTitle("Мои дела")
                
                Button {
                    isCreationModalPresented = true
                } label: {
                    Image("plus")
                        .resizable()
                        .shadow(radius: 4, x: 0, y: 4)
                }
                .frame(width: 44, height: 44)
                .padding()
            }
        } detail: {
            Text("")
        }
        .sheet(isPresented: $isCreationModalPresented) {
            TodoDetail(
                viewModel: TodoDetailViewModel(todoItem: nil, todoDetailModel: todoDetailModel),
                isPresented: $isCreationModalPresented
            )
        }
    }
}

#Preview {
    TodoList()
}
