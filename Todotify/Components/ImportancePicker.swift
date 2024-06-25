//
//  ImportancePicker.swift
//  Todotify
//
//  Created by Murad Azimov on 24.06.2024.
//

import SwiftUI

struct ImportancePicker: View {
    @Binding var importance: Importance

    var body: some View {
        Picker("", selection: $importance) {
            Image("importanceUnimportant").tag(Importance.unimportant)
            Text("нет").tag(Importance.usual)
            Image("importanceImportant").tag(Importance.important)
        }
        .pickerStyle(.segmented)
        .frame(width: 150)
    }
}
