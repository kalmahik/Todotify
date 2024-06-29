//
//  CP.swift
//  Todotify
//
//  Created by Murad Azimov on 29.06.2024.
//
import SwiftUI

struct ColorPickerView: View {
    @Binding var selectedColor: Color
    @State private var hue: Double = 0.0
    @State private var saturation: Double = 1.0
    @State private var brightness: Double = 1.0
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [
                        Color(hue: 0, saturation: saturation, brightness: brightness),
                        Color(hue: 1/6, saturation: saturation, brightness: brightness),
                        Color(hue: 2/6, saturation: saturation, brightness: brightness),
                        Color(hue: 3/6, saturation: saturation, brightness: brightness),
                        Color(hue: 4/6, saturation: saturation, brightness: brightness),
                        Color(hue: 5/6, saturation: saturation, brightness: brightness),
                        Color(hue: 1, saturation: saturation, brightness: brightness)
                    ]), startPoint: .leading, endPoint: .trailing))
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { value in
                                let width = UIScreen.main.bounds.width - 40
                                hue = Double(value.location.x / width)
                                hue = min(max(hue, 0), 1) // Clamping the value between 0 and 1
                                selectedColor = Color(hue: hue, saturation: saturation, brightness: brightness)
                            }
                    )
            }
            .frame(height: 300)
            .cornerRadius(10)
            .overlay(
                Rectangle()
                    .stroke(Color.black, lineWidth: 2)
            )
            
            Slider(value: $brightness, in: 0...1)
                .padding()
                .onChange(of: brightness) {
                    selectedColor = Color(hue: hue, saturation: 1.0, brightness: brightness)
                }
            
            HStack {
                Spacer()
                Button(action: {
                    // Dismiss the sheet
                }) {
                    Text("Done")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Spacer()
            }
            .padding()
        }
        .padding()
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView(selectedColor: .constant(.red))
    }
}
