//
//  TodoList.swift
//  Todotify
//
//  Created by kalmahik on 17.06.2024.
//

import CocoaLumberjackSwift
import SwiftUI

struct CategoryList: View {
    @ObservedObject var store: Store
    @State private var newCategoryName: String = ""
    @State private var newCategoryColor: Color = .clear

    var body: some View {
        NavigationSplitView {
            ZStack(alignment: .bottom) {
                Color.background
                    .edgesIgnoringSafeArea(.all)

                List {
                    Section {
                        ForEach(store.categories) { category in
                            CategoryRow(category: category)
                        }
                    }

                    Section {
                        VStack {
                            TextField("Введите имя новой категориии", text: $newCategoryName)
                                .padding()

                            ColorPicker(selectedColor: $newCategoryColor)
                                .padding(.horizontal, 20)

                            HStack {
                                let disabled = newCategoryName.isEmpty || newCategoryColor == .clear

                                Circle()
                                    .fill(newCategoryColor)
                                    .frame(width: 24, height: 24)
                                    .overlay(
                                        Circle()
                                            .stroke(.black, lineWidth: 2)
                                    )

                                Spacer()

                                Button(action: {
                                    if !newCategoryName.isEmpty {
                                        store.add(category: Category(name: newCategoryName, hexColor: newCategoryColor.toHex()))
                                        newCategoryName = ""
                                        newCategoryColor = .clear
                                    }
                                }) {
                                    Text("Сохранить")
                                        .foregroundColor(disabled ? Color.gray : Color.accentColor)
                                }
                                .disabled(disabled)
                                .opacity(disabled ? 0.5 : 1.0)

                            }
                            .padding()
                        }
                        .listRowInsets(EdgeInsets())
                    }
                }
                .navigationTitle("Категории")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    DDLogInfo("CATEGORY EDITION OPENED")
                }

            }
        } detail: {
            Text("")
        }
    }
}
