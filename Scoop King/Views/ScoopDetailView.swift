//
//  ScoopDetailView.swift
//  Scoop King
//
//  Created by Tad Clifton on 12/3/24.
//

import SwiftUI

struct ScoopDetailView: View {
    @State var scoop: IceCreamScoop
    var onSave: (IceCreamScoop) -> Void
    var onDelete: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            TextField("Flavor", text: $scoop.flavor)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Rating Control
            StarsSelectionView(rating: $scoop.rating)
                .padding()

            TextField("Description", text: $scoop.description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Spacer()

            HStack {
                Button("Save Changes") {
                    onSave(scoop) // Pass updated scoop back to ScoopView
                    dismiss()     // Dismiss the view
                }
                .buttonStyle(.borderedProminent)
                .padding()

                Button("Delete Scoop") {
                    onDelete()    // Delete the scoop
                    dismiss()     // Dismiss the view
                }
                .buttonStyle(.bordered)
                .foregroundColor(.red)
                .padding()
            }
        }
        .navigationTitle("Edit Scoop")
    }
}

struct ScoopDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ScoopDetailView(
            scoop: IceCreamScoop(
                id: "1",
                flavor: "Vanilla",
                rating: 4,
                description: "Classic vanilla",
                colorHex: "FFC107"
            ),
            onSave: { _ in },
            onDelete: { }
        )
    }
}
