//
//  TodoDetail.swift
//  Todotify
//
//  Created by kalmahik on 17.06.2024.
//

import CocoaLumberjackSwift
import SwiftUI

struct TodoDetail: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass

    @ObservedObject var store: Store
    @ObservedObject var viewModel: TodoDetailViewModel

    @State private var isCategoryModalPresented = false

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

                Section {
                    RowItem(title: "Важность") {
                        ImportancePicker(importance: $viewModel.importance)
                    }

                    RowItem(
                        title: "Цвет",
                        subtitle: viewModel.hexColor.toHex()
                    ) {
                        Circle()
                            .fill(viewModel.hexColor)
                            .frame(width: 24, height: 24)
                    }

                    ColorPicker(selectedColor: $viewModel.hexColor)

                    VStack {
                        RowItem(
                            title: "Выберите категорию",
                            subtitle: viewModel.category.name,
                            action: {  }
                        ) {
                            CategoryView(category: viewModel.category)

                            Button {
                                isCategoryModalPresented = true
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24)
                                    .foregroundColor(.blue)
                            }

                        }
                        CategoryPicker(selectedCategory: $viewModel.category, categories: store.categories)
                    }
                    .sheet(isPresented: $isCategoryModalPresented) {
                        CategoryList(store: store)
                    }

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
                            .listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
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
                    }
                    .disabled(viewModel.isSaveDisabled())
                }
            })
            .onAppear {
                DDLogInfo("TODO DETAIL OPENED")
            }
        }
    }
}

 #Preview {
    @State var todoItem = TodoItem(text: "preview") as TodoItem?
    @State var store = Store.shared
    let model = TodoDetailModel(store: store)
    let todoViewModel = TodoDetailViewModel(todoDetailModel: model, todoItem: todoItem)
    return TodoDetail(store: store, viewModel: todoViewModel)
 }
