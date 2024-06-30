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
            Image("custom.arrow.down").tag(Importance.unimportant)
            Text("нет").tag(Importance.usual)
            Image("custom.exclamationmark.2").tag(Importance.important)
        }
        .pickerStyle(.segmented)
        .frame(width: 150)
    }
}
