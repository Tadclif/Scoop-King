//
//  IceCreamScoop.swift
//  Scoop King
//
//  Created by Tad Clifton on 12/3/24.
//

import Foundation
import SwiftUI

struct IceCreamScoop: Identifiable, Codable {
    var id: String? // Firestore document ID
    var flavor: String
    var rating: Int
    var description: String
    var colorHex: String // Store the scoop's color as a hex string

    // Computed property to convert colorHex into a Color
    var color: Color {
        Color(hex: colorHex) ?? .white
    }

    // Convert the model to a dictionary for Firestore
    var dictionary: [String: Any] {
        return [
            "flavor": flavor,
            "rating": rating,
            "description": description,
            "colorHex": colorHex
        ]
    }
}

// Utility extension to handle Color <-> Hex conversion
extension Color {
    init?(hex: String) {
        guard let rgb = UInt(hex, radix: 16) else { return nil }
        self.init(
            red: Double((rgb >> 16) & 0xFF) / 255.0,
            green: Double((rgb >> 8) & 0xFF) / 255.0,
            blue: Double(rgb & 0xFF) / 255.0
        )
    }

    func toHex() -> String {
        let components = UIColor(self).cgColor.components ?? [0, 0, 0]
        let r = Int(components[0] * 255.0)
        let g = Int(components[1] * 255.0)
        let b = Int(components[2] * 255.0)
        return String(format: "%02X%02X%02X", r, g, b)
    }
}
