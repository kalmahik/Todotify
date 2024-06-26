//
//  TodoDetail.swift
//  Todotify
//
//  Created by kalmahik on 17.06.2024.
//

import SwiftUI

struct TodoDetail: View {
    @ObservedObject var viewModel: TodoDetailViewModel
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationStack {
            ScrollView {
                TextEditor(text: $viewModel.text)
                    .frame(minHeight: 120)
                    .border(Color.black)
                
                RowItem(title: "Важность") {
                    ImportancePicker(importance: $viewModel.importance)
                }
                
                RowItem(title: "Сделать до") {
                    Toggle("", isOn: $viewModel.isDeadlineEnabled)
                }
                
                VStack {
                    DeadlinePicker(deadline: $viewModel.deadline, isDeadlineEnabled: $viewModel.isDeadlineEnabled)
                    
                    Button(role: .destructive, action: {
                        viewModel.deleteTodo()
                        isPresented = false
                    }) {
                        Text("Удалить")
                            .frame(maxWidth: .infinity)
                    }
                    .frame(height: 56)
                    .border(Color.black)
                    .disabled(viewModel.todoItem?.id == nil)
                }
                .animation(.easeOut, value: viewModel.isDeadlineEnabled)
                
                
            }
            .navigationTitle("Дело")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Отменить") {
                        isPresented = false
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Сохранить") {
                        viewModel.saveTodo()
                        isPresented = false
                    }
                }
            })
        }
    }
}

#Preview {
    @State var isPresented = true
    @State var todo = TodoItem(text: "123") as TodoItem?
    let viewModel = TodoDetailViewModel(todoItem: todo, todoDetailModel: FileCache())
    return TodoDetail(viewModel: viewModel, isPresented: $isPresented)
}
