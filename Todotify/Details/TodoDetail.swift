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
                VStack(spacing: 16) {
                    TextEditor(text: $viewModel.text)
                        .frame(minHeight: 120)
                        .contentMargins(.all, 16)
                        .background(.white)
                        .cornerRadius(16)
                        .padding(.horizontal)
                    
                    VStack(spacing: 0) { // TODO: разобраться со спейсингом
                        RowItem(title: "Важность") {
                            ImportancePicker(importance: $viewModel.importance)
                        }
                        
                        Divider()
                            .padding(.horizontal)
                        
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
                            Divider()
                                .padding(.horizontal)
                            
                            DeadlinePicker(deadline: $viewModel.deadline)
                                .padding(.horizontal)
                                .animation(.easeInOut, value: viewModel.isPickerShowed)
                        }
                    }
                    .background(.white)
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    Button(role: .destructive, action: {
                        viewModel.deleteTodo()
                        isPresented = false
                    }) {
                        Text("Удалить")
                            .frame(maxWidth: .infinity)
                    }
                    .frame(height: 56)
                    .background(.white)
                    .cornerRadius(16)
                    .padding(.horizontal)
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
            .background(Color.background)
        }
        
    }
    
}

#Preview {
    @State var isPresented = true
    @State var todo = TodoItem(text: "123") as TodoItem?
    let viewModel = TodoDetailViewModel(todoItem: todo, todoDetailModel: FileCache())
    return TodoDetail(viewModel: viewModel, isPresented: $isPresented)
}
