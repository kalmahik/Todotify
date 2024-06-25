//
//  DeadlinePicker.swift
//  Todotify
//
//  Created by Murad Azimov on 24.06.2024.
//

import SwiftUI

struct DeadlinePicker: View {
    @Binding var deadline: Date
    @Binding var isDeadlineEnabled: Bool
    
    var body: some View {
        DatePicker("", selection: $deadline, displayedComponents: .date)
            .datePickerStyle(.graphical)
            .frame(height: isDeadlineEnabled ? nil : 0, alignment: .top)
            .clipped()
            .background {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .foregroundColor(Color(UIColor.systemBackground))
                    .shadow(radius: 1)
            }
            .padding()
    }
}
