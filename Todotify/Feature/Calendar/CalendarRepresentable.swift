//
//  CalendarWrapper.swift
//  Todotify
//
//  Created by Murad Azimov on 02.07.2024.
//

import SwiftUI

struct CalendarRepresentable: UIViewControllerRepresentable {
    @ObservedObject var store: Store

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if let view = uiViewController as? CalendarViewController {
            view.updateData(store: store)
        }
    }

    func makeUIViewController(context: Context) -> some UIViewController {
        let model = CalendarModel(store: store)
        let viewModel = CalendarViewModel(for: model)
        let view = CalendarViewController(for: viewModel, store: store)
        return view
    }
}
