//
//  RankingView.swift
//  Scoop King
//
//  Created by Tad Clifton on 12/3/24.
//

import SwiftUI

struct RankingView: View {
    @State var scoop: IceCreamScoop?
    @State var flavor: String
    @State var rating: Int
    var onSave: (IceCreamScoop) -> Void
    
    init(scoop: IceCreamScoop?, onSave: @escaping (IceCreamScoop) -> Void) {
        self.scoop = scoop
        self.flavor = scoop?.flavor ?? ""
        self.rating = scoop?.rating ?? 1
        self.onSave = onSave
    }
    
    var body: some View {
        VStack {
            TextField("Flavor", text: $flavor)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Stepper("Rating: \(rating)", value: $rating, in: 1...5)
                .padding()
            
//            Button("Save") {
//                let updatedScoop = IceCreamScoop(id: scoop?.id ?? UUID().uuidString, flavor: flavor, rating: rating)
//                onSave(updatedScoop)
//            }
            .padding()
        }
    }
}


