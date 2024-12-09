//
//  IceCreamScoopView.swift
//  Scoop King
//
//  Created by Tad Clifton on 12/3/24.
//

import SwiftUI

struct IceCreamScoopView: View {
    let scoop: IceCreamScoop

    var body: some View {
        Image("scoop") // Your transparent PNG image
            .resizable()
            .scaledToFit()
            .frame(width: 200, height: 200)
            .colorMultiply(Color(hex: scoop.colorHex) ?? .white)
            .shadow(radius: 5)
    }
}

struct IceCreamScoopView_Previews: PreviewProvider {
    static var previews: some View {
        IceCreamScoopView(
            scoop: IceCreamScoop(
                id: "1",
                flavor: "Vanilla",
                rating: 4,
                description: "Classic vanilla flavor.",
                colorHex: "FFFFFFF" // Example color (Yellow)
            )
        )
    }
}
