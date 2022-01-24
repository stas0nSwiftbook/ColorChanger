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
    
    @State private var textFieldValue = ""
    @State private var alertIsShown = false
    
    var body: some View {
        HStack {
            Text("\(lround(sliderValue))")
                .frame(width: 45)
            
            Slider(value: $sliderValue, in: sliderRange)
                .tint(color)
            
            TextField("", text: $textFieldValue, onCommit: checkInput)
                .frame(width: 45)
                .textFieldStyle(.roundedBorder)
                .onAppear {
                    textFieldValue = "\(lround(sliderValue))"
                }
                .onChange(of: sliderValue) { _ in
                    textFieldValue = "\(lround(sliderValue))"
                }
                .onChange(of: textFieldValue) { _ in
                    checkInput()
                }
                .alert("Wrong input", isPresented: $alertIsShown, actions: {}) {
                    Text("Number must be in range\nfrom 0 to 255.\nPlease enter value again.")
                }
        }
        .foregroundColor(color)
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("Done") {
                    
                }
            }
        }
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
    static let range: ClosedRange<Double> = 0...255
    
    static var previews: some View {
        ColorSliderView(sliderValue: $sliderValue, sliderRange: range, color: .red)
    }
}
