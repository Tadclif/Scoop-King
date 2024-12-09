//
//  ScoopColoringView.swift
//  Scoop King
//
//  Created by Tad Clifton on 12/5/24.
//


import SwiftUI

struct ScoopColoringView: View {
    @State private var red: Double = 1.0
    @State private var green: Double = 1.0
    @State private var blue: Double = 1.0

    // Computed color based on user input
    private var selectedColor: Color {
        Color(red: red, green: green, blue: blue)
    }

    var body: some View {
        VStack {
            // Ice cream scoop with dynamic color
            Image("scoop")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .colorMultiply(selectedColor) // Apply the dynamic color to the scoop

            Spacer().frame(height: 20)

            // RGB Sliders
            VStack {
                HStack {
                    Text("Red")
                    Slider(value: $red, in: 0...1)
                        .accentColor(.red)
                }
                HStack {
                    Text("Green")
                    Slider(value: $green, in: 0...1)
                        .accentColor(.green)
                }
                HStack {
                    Text("Blue")
                    Slider(value: $blue, in: 0...1)
                        .accentColor(.blue)
                }
            }
            .padding()

            Spacer()
        }
        .navigationTitle("Customize Your Scoop")
    }
}

struct ScoopColoringView_Previews: PreviewProvider {
    static var previews: some View {
        ScoopColoringView()
    }
}