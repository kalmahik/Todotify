//
//  TodoDetail.swift
//  Todotify
//
//  Created by kalmahik on 17.06.2024.
//

import SwiftUI

struct TodoDetail: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    @ObservedObject var viewModel: TodoDetailViewModel
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ZStack(alignment: .trailing) {
                        TextEditor(text: $viewModel.text)
                            .frame(minHeight: 120)
                            .contentMargins(.all, 16)
                        
                        Rectangle()
                            .fill(viewModel.hexColor)
                            .frame(width: 5)
                    }
                    .listRowInsets(EdgeInsets())
                }
                
                Section() {
                    RowItem(title: "Важность") {
                        ImportancePicker(importance: $viewModel.importance)
                    }
                    
                    RowItem(
                        title: "Цвет",
                        subtitle: viewModel.hexColor.toHexString()
                    ) {
                        Circle()
                            .fill(viewModel.hexColor)
                            .frame(width: 24, height: 24)
                    }
                    
                    ColorPicker(selectedColor: $viewModel.hexColor)
                    
                    RowItem(
                        title: "Сделать до",
                        subtitle: viewModel.getDeadlineString(),
                        action: viewModel.datePickerToggle
                    ) {
                        Toggle("", isOn: $viewModel.isDeadlineEnabled)
                            .onChange(of: viewModel.isDeadlineEnabled) {
                                viewModel.showDatePicker()
                            }
                    }
                    
                    if viewModel.isDeadlineEnabled && viewModel.isDatePickerShowed {
                        DeadlinePicker(deadline: $viewModel.deadline)
                            .animation(.easeInOut, value: viewModel.isDatePickerShowed)
                            .transition(.slide)
                            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    }
                }
                
                Section {
                    Button(role: .destructive, action: {
                        viewModel.deleteTodo()
                        dismiss()
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
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Сохранить") {
                        viewModel.saveTodo()
                        dismiss()
                    }.disabled(viewModel.isSaveDisabled())
                }
            })
        }
    }
}

#Preview {
    @State var todo = TodoItem(text: "preview") as TodoItem?
    let viewModel = TodoDetailViewModel(todoItem: todo, todoDetailModel: FileCache())
    return TodoDetail(viewModel: viewModel)
}
