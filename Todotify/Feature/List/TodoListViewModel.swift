//
//  TodoListViewModel.swift
//  Todotify
//
//  Created by Murad Azimov on 18.07.2024.
//

import Combine
import SwiftUI

final class TodoListViewModel: ObservableObject {
    private let store: Store
    private let networkService = DefaultNetworkingService.shared

    init(store: Store) {
        self.store = store
    }

    func fetchTodos() {
        Task {
            let list = try? await networkService.fetchTodos()
            if let list {
                await MainActor.run {
                    store.replace(todos: list)
                }
            }
        }
    }
}
