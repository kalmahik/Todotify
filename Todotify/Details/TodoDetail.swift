//
//  TodoDetail.swift
//  Todotify
//
//  Created by kalmahik on 17.06.2024.
//

import SwiftUI

struct TodoDetail: View {
    var todo: TodoItem?
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: FileCache
    
    @State private var text = ""
    @State private var importance = Importance.usual
    @State private var deadline = Date()
    @State private var isDeadlineEnabled = false
    
    init(todo: TodoItem?, isPresented: Binding<Bool>, viewModel: FileCache) {
        self.todo = todo
        self._isPresented = isPresented
        self._viewModel = ObservedObject(wrappedValue: viewModel)
        _text = State(initialValue: todo?.text ?? "")
        _importance = State(initialValue: todo?.importance ?? .usual)
        _deadline = State(initialValue: todo?.deadline ?? Date())
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                TextEditor(text: $text)
                    .frame(minHeight: 120)
                    .border(Color.black)
                
                RowItem(title: "Важность") {
                    ImportancePicker(importance: $importance)
                }
                
                RowItem(title: "Сделать до") {
                    Toggle("", isOn: $isDeadlineEnabled)
                }
                
                VStack {
                    DeadlinePicker(deadline: $deadline, isDeadlineEnabled: $isDeadlineEnabled)
                    
                    Button(role: .destructive, action: {}) {
                        Text("Delete")
                            .frame(maxWidth: .infinity)
                    }
                    .frame(height: 56)
                    .border(Color.black)
                    .disabled(true)
                }
                .animation(.easeOut, value: isDeadlineEnabled)
                
                
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
                        viewModel.add(todo: TodoItem(
                            text: text,
                            importance: importance,
                            deadline: isDeadlineEnabled ? deadline : nil
                        ))
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
    @ObservedObject var viewModel = FileCache()
    return TodoDetail(todo: todo, isPresented: $isPresented, viewModel: viewModel)
}
