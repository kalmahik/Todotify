//
//  TodoList.swift
//  Todotify
//
//  Created by kalmahik on 17.06.2024.
//

import SwiftUI

struct TodoList: View {
    @StateObject var store = Store()
        
    @State private var isCreationModalPresented = false
    @State private var selectedTodoItem: TodoItem?
    
    var body: some View {
        NavigationSplitView {
            ZStack(alignment: .bottom) {
                Color.background
                    .edgesIgnoringSafeArea(.all)
                
                List() {
                    Section {
                        ForEach(store.todos) { todoItem in
                            Button(action: {
                                selectedTodoItem = todoItem
                            }) {
                                let model = TodoDetailModel(store: store)
                                let viewModel = TodoDetailViewModel(todoDetailModel: model, todoItem: todoItem)
                                TodoRow(todo: todoItem, completeToggle: viewModel.completeToggle)
                            }
                            .swipeActions(allowsFullSwipe: true) {
                                let model = TodoDetailModel(store: store)
                                let viewModel = TodoDetailViewModel(todoDetailModel: model, todoItem: todoItem)
                                Button(role: .destructive, action: viewModel.deleteTodo) {
                                    Image(systemName: "trash.fill")
                                }
                                .tint(.red)
                                
                                Button(action: { selectedTodoItem = todoItem }) {
                                    Image(systemName: "info.circle.fill")
                                }
                                .tint(.gray)
                            }
                            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                let model = TodoDetailModel(store: store)
                                let viewModel = TodoDetailViewModel(todoDetailModel: model, todoItem: todoItem)
                                Button(action: viewModel.completeToggle) {
                                    Image(systemName: "checkmark.circle")
                                }
                                .tint(.green)
                            }
                            .listRowInsets(EdgeInsets(.zero))
                        }
                        
                    } header: {
                        HStack {
                            Text("Выполнено – \(store.todos.filter { $0.isCompleted}.count)")
                            Spacer()
                            Text("Показать")
                                .foregroundColor(.accentColor)
                        }
                    }
                    
                }
                .safeAreaPadding(.bottom, 66)
                .overlay(Group {
                    if store.todos.isEmpty {
                        Text("Ой, кажется тут ничего нет...")
                    }
                })
                .navigationTitle("Мои дела")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if (!store.todos.isEmpty) {
                            NavigationLink() {
                                CalendarWrapper(store: store)
                                    .navigationTitle("Мои дела")
                                    .toolbarRole(.editor)
                                    .ignoresSafeArea()
                            } label: {
                                Image(systemName: "calendar")
                            }
                        }
                    }
                })
                
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
            let model = TodoDetailModel(store: store)
            let viewModel = TodoDetailViewModel(todoDetailModel: model, todoItem: todoItem)
            TodoDetail(store: store, viewModel:viewModel)
        }
        .sheet(isPresented: $isCreationModalPresented) {
            let model = TodoDetailModel(store: store)
            let viewModel = TodoDetailViewModel(todoDetailModel: model, todoItem: nil)
            TodoDetail(store: store, viewModel:viewModel)
        }
        .environmentObject(store)
    }
}

#Preview {
    TodoList()
}
