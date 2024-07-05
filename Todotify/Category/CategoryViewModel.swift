//
//  CategoryViewModel.swift
//  Todotify
//
//  Created by kalmahik on 07.05.2024.

import Foundation

typealias CategoryBinding<T> = (T) -> Void

final class CategoryViewModel {
    var isEmptyStateBinding: CategoryBinding<Bool>?
    var categoriesBinding: CategoryBinding<[Category]>?
    var selectedCategoryBinding: CategoryBinding<Category?>?

    private let model: CategoryModel

    init(for model: CategoryModel) {
        self.model = model
    }

    func loadCategories() {
        categoriesBinding?(model.categories)
        isEmptyStateBinding?(model.categories.isEmpty)
//        selectedCategoryBinding?(model.selectedCategory)
        updateCategoriesUI()
    }

    func didSelectRowAt(indexPath: IndexPath) {
        let category = model.categories[indexPath.row]
//        model.changeCategory(category: category)
        loadCategories()
    }

    func createCategory(categoryName: String) {
        let category = Category(name: categoryName, hexColor: "#000000")
        model.add(category: category)
        loadCategories()
    }

    private func updateCategoriesUI() {
        NotificationCenter.default.post(name: CategoriesViewController.reloadCollection, object: self)
    }
}
