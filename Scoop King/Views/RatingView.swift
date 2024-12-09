//
//  RatingView.swift
//  Scoop King
//
//  Created by Tad Clifton on 12/3/24.
//

import SwiftUI

struct RatingView: View {
    @State var flavor: String = ""
    @State var rating: Int
    @State var description: String = ""
    @State private var red: Double = 1.0
    @State private var green: Double = 1.0
    @State private var blue: Double = 1.0
    
    var onSave: (IceCreamScoop) -> Void
    var onCancel: () -> Void
    
    private var selectedColor: Color {
        Color(red: red, green: green, blue: blue)
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // Preview of the dynamically changing scoop
                VStack {
                    Spacer()
                    
                    Text("Make Your Scoop!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.green)
                    
                    Spacer()
                    
                    TextField("Flavor Name", text: $flavor)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    
                    StarsSelectionView(rating: $rating) // Rating stars
                        .padding()
                    
                    TextField("Description", text: $description)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                }
                
                // Color Sliders
                VStack {
                    Text("Choose Your Scoop Color")
                        .font(.headline)
                    
                    Image("scoop")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .colorMultiply(selectedColor)
                    
                    
                    HStack {
                        Text("Red")
                        Slider(value: $red, in: 0...1)
                            .accentColor(.red)
                    }.padding(.horizontal)
                    
                    HStack {
                        Text("Green")
                        Slider(value: $green, in: 0...1)
                            .accentColor(.green)
                    }.padding(.horizontal)
                    
                    HStack {
                        Text("Blue")
                        Slider(value: $blue, in: 0...1)
                            .accentColor(.blue)
                    }.padding(.horizontal)
                }
                
                Spacer()
                
                // Save and Cancel Buttons
                HStack {
                    Button("Cancel") {
                        onCancel()
                    }
                    .buttonStyle(.bordered)
                    .padding()
                    
                    Button("Save") {
                        let hexColor = selectedColor.toHex()
                        let newScoop = IceCreamScoop(
                            id: nil,
                            flavor: flavor,
                            rating: rating,
                            description: description,
                            colorHex: hexColor
                        )
                        onSave(newScoop)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
                .padding(.bottom, geometry.safeAreaInsets.bottom)
            }
            .navigationTitle("Add Scoop")
        }
    }
}

#Preview {
    RatingView(
        flavor: "Vanilla",
        rating: 3,
        description: "Classic vanilla flavor",
        onSave: { _ in },
        onCancel: {}
    )
}
