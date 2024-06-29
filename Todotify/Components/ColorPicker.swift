//
//  CustomColorPicker.swift
//  Todotify
//
//  Created by Murad Azimov on 22.06.2024.
//

import SwiftUI

struct ColorPicker: View {
    @Binding var selectedColor: Color
    
    @State private var hue: Double = 0.0
    @State private var brightness: Double = 1.0
    @State private var size: CGSize = .zero
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [
                    convertColor(hue: 0/6),
                    convertColor(hue: 1/6),
                    convertColor(hue: 2/6),
                    convertColor(hue: 3/6),
                    convertColor(hue: 4/6),
                    convertColor(hue: 5/6),
                    convertColor(hue: 6/6),
                ]), startPoint: .leading, endPoint: .trailing))
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            hue = Double(value.location.x / size.width)
                            hue = min(max(hue, 0), 1)
                            selectedColor = convertColor(hue: hue)
                        }
                )
                .frame(height: 100)
                .cornerRadius(12)
            
            Slider(value: $brightness, in: 0...1)
                .onChange(of: brightness) {
                    selectedColor = Color(hue: hue, saturation: 1.0, brightness: brightness)
                }
            
            GeometryReader { proxy in
                HStack {} // just an empty container to triggers the onAppear
                    .onAppear {
                        size = proxy.size
                    }
            }
            
            //            Rectangle()
            //                .fill(selectedColor)
            //                .frame(height: 100)
            //                .cornerRadius(16)
            //                .padding()
            
        }
        .padding()
    }
    
    func convertColor(hue: Double) -> Color {
        return Color(hue: hue, saturation: 1, brightness: brightness)
    }
}

#Preview {
    @State var color = Color.blue
    return ColorPicker(selectedColor: $color)
}
