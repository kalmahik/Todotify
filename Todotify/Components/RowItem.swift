//
//  ImportancePicker.swift
//  Todotify
//
//  Created by Murad Azimov on 24.06.2024.
//

import SwiftUI

struct RowItem<Content: View>: View {
    let title: String
    let component: Content
    
    init(title: String, @ViewBuilder component: () -> Content) {
        self.title = title
        self.component = component()
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            component
        }
        .padding()
        .border(Color.black, width: 1)
    }
}


#Preview {
    ContentView()
}
