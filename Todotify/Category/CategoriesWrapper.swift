//
//  CategoriesWrapper.swift
//  Todotify
//
//  Created by Murad Azimov on 05.07.2024.
//

import SwiftUI

struct CategoriesWrapper : UIViewControllerRepresentable {
    @Binding var selectedCategory: Category?
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
//        if let view = uiViewController as? CategoriesViewController  {
//            view.updateData(store: store)
//        }
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let model = CategoryModel()
        let viewModel = CategoryViewModel(for: model)
        let view = CategoriesViewController(for: viewModel)
        return view
    }
}
