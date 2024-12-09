//
//  StarsSelectionView.swift
//  Scoop King
//
//  Created by Tad Clifton on 12/4/24.
//

import SwiftUI

struct StarsSelectionView: View {
    @Binding var rating: Int
    let highestRating = 5
    let unselected = Image(systemName: "star")
    let selected = Image(systemName: "star.fill")
    let font: Font = .largeTitle
    let fillColor: Color = .yellow
    let emptyColor: Color = .gray

    var body: some View {
        HStack {
            ForEach(1...highestRating, id: \.self) { number in
                showStar(for: number)
                    .foregroundColor(number <= rating ? fillColor : emptyColor)
                    .onTapGesture {
                        print("Tapped on star: \(number)")
                        rating = number // Set the selected rating
                    }
            }
            .font(font)
        }
    }

    func showStar(for number: Int) -> Image {
        if number > rating {
            return unselected
        } else {
            return selected
        }
    }
}


struct StarsSelectionView_Previews: PreviewProvider {
    @State static var previewRating = 4
    static var previews: some View {
        StarsSelectionView(rating: $previewRating)
    }
}
