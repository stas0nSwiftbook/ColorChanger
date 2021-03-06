//
//  ContentView.swift
//  ColorChanger
//
//  Created by Станислав Буйновский on 24.01.2022.
//

import SwiftUI


struct MainView: View {
        
    @State private var redSliderValue = Double.random(in: 0...255)
    @State private var greenSliderValue = Double.random(in: 0...255)
    @State private var blueSliderValue = Double.random(in: 0...255)
    @FocusState private var focused: Bool

    private let sliderRange: ClosedRange<Double> = 0...255
    
    var body: some View {
        VStack {
            ColorRectangleView()
                .foregroundColor( Color(
                    red: redSliderValue/255,
                    green: greenSliderValue/255,
                    blue: blueSliderValue/255,
                    opacity: 1.0))
            
            ColorSliderView(
                sliderValue: $redSliderValue,
                sliderRange: sliderRange,
                color: .red,
                focused: $focused)
            ColorSliderView(
                sliderValue: $greenSliderValue,
                sliderRange: sliderRange,
                color: .green,
                focused: $focused)
            ColorSliderView(
                sliderValue: $blueSliderValue,
                sliderRange: sliderRange,
                color: .blue,
                focused: $focused)
            
            Spacer()
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button("Done") {
                        focused = false
                    }
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct ColorRectangleView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 40)
            .frame(height: 200)
            .overlay(
                RoundedRectangle(cornerRadius: 40).stroke(Color.gray, lineWidth: 4)
            )
    }
}
