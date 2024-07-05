//
//  ImportancePicker.swift
//  Todotify
//
//  Created by Murad Azimov on 24.06.2024.
//

import SwiftUI

struct RowItem<Content: View>: View {
    let title: String
    let subtitle: String?
    let component: Content
    let action: (() -> Void)?
    
    init(title: String, subtitle: String? = nil, action: (() -> Void)? = nil,  @ViewBuilder component: () -> Content) {
        self.title = title
        self.subtitle = subtitle
        self.component = component()
        self.action = action
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                if let subtitle {
                    Text(subtitle)
                        .font(.system(size: 13))
                        .foregroundStyle(Color.accentColor)
                }
            }
            .border(Color.black)
            .onTapGesture { action?() }
            Spacer()
            component
        }
        .border(Color.black)
        .frame(height: 56)
        .animation(.easeInOut, value: subtitle)
        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }
}
