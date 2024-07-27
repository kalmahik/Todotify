//
//  FileCache.swift
//  Todotify
//
//  Created by Murad Azimov on 26.07.2024.
//

import Foundation
import SwiftData

public actor FileCache: ModelActor {

    public let modelContainer: ModelContainer
    public let modelExecutor: any ModelExecutor
    private var context: ModelContext { modelExecutor.modelContext }

    public init(container: ModelContainer) {
        self.modelContainer = container
        let context = ModelContext(modelContainer)
        modelExecutor = DefaultSerialModelExecutor(modelContext: context)
    }

    public func fetchData<T: PersistentModel>(
        predicate: Predicate<T>? = nil,
        sortBy: [SortDescriptor<T>] = []
    ) throws -> [T] {
        let fetchDescriptor = FetchDescriptor<T>(predicate: predicate, sortBy: sortBy)
        let list: [T] = try context.fetch(fetchDescriptor)
        return list
    }

    public func fetchCount<T: PersistentModel>(
        predicate: Predicate<T>? = nil,
        sortBy: [SortDescriptor<T>] = []
    ) throws -> Int {
        let fetchDescriptor = FetchDescriptor<T>(predicate: predicate, sortBy: sortBy)
        let count = try context.fetchCount(fetchDescriptor)
        return count
    }

    public func insert<T: PersistentModel>(data: T) {
        let context = data.modelContext ?? context
        context.insert(data)
    }

    public func save() throws {
        try context.save()
    }

    public func remove<T: PersistentModel>(predicate: Predicate<T>? = nil) throws {
        try context.delete(model: T.self, where: predicate)
    }

    public func saveAndInsertIfNeeded<T: PersistentModel>(
        data: T,
        predicate: Predicate<T>
    ) throws {
        let descriptor = FetchDescriptor<T>(predicate: predicate)
        let context = data.modelContext ?? context
        let savedCount = try context.fetchCount(descriptor)

        if savedCount == 0 {
            context.insert(data)
        }
        try context.save()
    }
}
