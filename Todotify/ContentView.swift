//
//  ContentView.swift
//  Todotify
//
//  Created by kalmahik on 17.06.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var text = ""
    @State private var isDeadlineEnabled = false
    var body: some View {
        ScrollView {
            TextEditor(text: $text)
                .frame(minHeight: 120)
                .border(Color.black)
            
            RowItem(title: "Важность") {
                ImportancePicker()
            }
            RowItem(title: "Сделать до") {
                Toggle("", isOn: $isDeadlineEnabled)
            }
            
            Button(role: .destructive, action: {}) {
                Text("Delete")
                    .frame(maxWidth: .infinity)
            }
                .frame(height: 56)
                .border(Color.black)
                .disabled(true)
        }
    }
}

#Preview {
    ContentView()
}
