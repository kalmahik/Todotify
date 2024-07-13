//
//  DeadlinePicker.swift
//  Todotify
//
//  Created by Murad Azimov on 24.06.2024.
//

import SwiftUI

struct DeadlinePicker: View {
    @Binding var deadline: Date

    var body: some View {
        DatePicker("", selection: $deadline, in: Date()..., displayedComponents: .date)
            .datePickerStyle(.graphical)
            .clipped()
    }
}
