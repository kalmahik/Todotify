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
            List {
                Section {
                    TextEditor(text: $viewModel.text)
                        .frame(minHeight: 120)
                        .contentMargins(.vertical, 16)
                }
                
                Section() {
                    RowItem(title: "Важность") {
                        ImportancePicker(importance: $viewModel.importance)
                    }
                                        
                    RowItem(
                        title: "Сделать до",
                        subtitle: viewModel.getDeadlineString(),
                        action: viewModel.pickerToggle
                    ) {
                        Toggle("", isOn: $viewModel.isDeadlineEnabled)
                            .onChange(of: viewModel.isDeadlineEnabled) {
                                viewModel.showPicker()
                            }
                    }
                    
                    if viewModel.isDeadlineEnabled && viewModel.isPickerShowed {
                        DeadlinePicker(deadline: $viewModel.deadline)
                            .animation(.easeInOut, value: viewModel.isPickerShowed)
                            .transition(.slide)
                            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    }
                }
                
                Section {
                    Button(role: .destructive, action: {
                        viewModel.deleteTodo()
                        isPresented = false
                    }) {
                        Text("Удалить")
                            .frame(height: 56)
                            .frame(maxWidth: .infinity)
                    }
                    .listRowInsets(EdgeInsets())
                    .disabled(viewModel.todoItem?.id == nil)
                }
    
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
