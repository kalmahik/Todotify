//
//  TodoListViewModel.swift
//  Todotify
//
//  Created by Murad Azimov on 18.07.2024.
//

import SwiftData
import SwiftUI

final class TodoListViewModel: ObservableObject {
    private let store: Store
    private let networkService = DefaultNetworkingService.shared

    init(store: Store) {
        self.store = store
    }

    func fetchTodos() {
        Task {
            do {
                var container = try ModelContainer(for: TodoItem.self)
                var fileCache = FileCache(container: container)
                let sortDescriptor = SortDescriptor<TodoItem>(\TodoItem.createdAt)
                let listSD: [TodoItem] = try await fileCache.fetchData(sortBy: [sortDescriptor])
                await MainActor.run {
                    store.replace(todos: listSD)
                }

                let listDN = try? await networkService.fetchTodos()
                if let listDN {
                    await MainActor.run {
                        store.replace(todos: listDN)
                    }

                    for todo in listDN {
                        await fileCache.insert(data: todo)
                    }

//                    try? await fileCache.save()
                }

            } catch {
                print("Failed to fetch data: \(error)")
            }
        }
    }
}
