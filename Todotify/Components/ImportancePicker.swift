//
//  ImportancePicker.swift
//  Todotify
//
//  Created by Murad Azimov on 24.06.2024.
//

import SwiftUI

struct ImportancePicker: View {
    @State private var importance = Importance.usual

    var body: some View {
        Picker("", selection: $importance) {
            Image("importanceUnimportant").tag(Importance.unimportant)
            Text("нет").tag(Importance.usual)
            Image("importanceImportant").tag(Importance.unimportant)
        }
        .pickerStyle(.segmented)
        .frame(width: 150)
    }
}


#Preview {
    ContentView()
}
