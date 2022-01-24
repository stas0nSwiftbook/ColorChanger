//
//  ColorSlider.swift
//  ColorChanger
//
//  Created by Станислав Буйновский on 24.01.2022.
//

import SwiftUI

struct ColorSliderView: View {
    
    @Binding var sliderValue: Double
    let sliderRange: ClosedRange<Double>
    let color: Color
    var focused: FocusState<Bool>.Binding
    @State private var textFieldValue = ""
    @State private var alertIsShown = false
    
    var body: some View {
        HStack {
            Text("\(lround(sliderValue))")
                .frame(width: 45)
            
            Slider(value: $sliderValue, in: sliderRange)
                .tint(color)
                .onChange(of: sliderValue) { _ in
                    textFieldValue = "\(lround(sliderValue))"
                }
            
            TextField("", text: $textFieldValue, onEditingChanged: { _ in checkInput() })
                .frame(width: 45)
                .textFieldStyle(.roundedBorder)
                .onAppear {
                    textFieldValue = "\(lround(sliderValue))"
                }
                .keyboardType(.decimalPad)
                .focused(focused)
                .alert("Wrong input", isPresented: $alertIsShown, actions: {}) {
                    Text("Number must be from 0 to 255. Please enter value again.")
                }
        }
        .foregroundColor(color)
    }
    
    private func checkInput() {
        if let value = Double(textFieldValue), sliderRange.contains(value) {
            sliderValue = value
            return
        }
        alertIsShown.toggle()
        sliderValue = 0
    }
}

struct ColorSlider_Previews: PreviewProvider {
    @State static var sliderValue = 125.0
    @FocusState static var focused: Bool
    static let range: ClosedRange<Double> = 0...255
    
    static var previews: some View {
        ColorSliderView(sliderValue: $sliderValue, sliderRange: range, color: .red, focused: $focused)
    }
}
