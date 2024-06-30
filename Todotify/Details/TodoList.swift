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
    @State private var selectedTodoItem: TodoItem?

    var body: some View {
        NavigationSplitView {
            ZStack(alignment: .bottom) {
                Color.background
                    .edgesIgnoringSafeArea(.all)
                
                List() {
                    Section {
                        ForEach(todoDetailModel.todos) { todoItem in
                            let viewModel = TodoDetailViewModel(todoItem: todoItem, todoDetailModel: todoDetailModel)
                            Button(action: {
                                selectedTodoItem = todoItem
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
                                    selectedTodoItem = todoItem
                                } label: {
                                    Label("Инфо", systemImage: "info.circle.fill")
                                }
                                .tint(.gray)
                            }
                            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                Button {
                                    viewModel.completeToggle()
                                }
                            label: { Image(systemName: "checkmark.circle") }
                            }
                            .tint(.green)
                            .listRowInsets(EdgeInsets(.zero))
                        }
                        
                    } header: {
                        HStack {
                            Text("Выполнено – \(todoDetailModel.todos.filter { $0.isCompleted}.count)")
                            Spacer()
                            Text("Показать")
                                .foregroundColor(.accentColor)
                        }
                    }
                    
                }
                .safeAreaPadding(.bottom, 66)
                .navigationTitle("Мои дела")
                
                Button {
                    isCreationModalPresented = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .background(.white)
                        .frame(width: 44)
                        .foregroundColor(.blue)
                        .clipShape(Circle())
                        .shadow(radius: 4, x: 0, y: 4)
                }
                .padding()
            }
        } detail: {
            Text("")
        }
        .sheet(item: $selectedTodoItem) { todoItem in
            TodoDetail(viewModel: TodoDetailViewModel(todoItem: todoItem, todoDetailModel: todoDetailModel))
        }
        .sheet(isPresented: $isCreationModalPresented) {
            TodoDetail(viewModel: TodoDetailViewModel(todoItem: nil, todoDetailModel: todoDetailModel))
        }
    }
}

#Preview {
    TodoList()
}
