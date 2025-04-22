//
//  User.swift
//  RoomateApp
//
//  Created by David Abundis & Christopher Nastasi on 4/10/25.
//

import Foundation
import SwiftUI
import UIKit

struct User: Hashable, Codable, Identifiable {
    // Properties
    var id = UUID()
    var name: String
    var email: String?
    var profilePicture: String?
    var points: Int = nil as Int? ?? 0
    var color: String?
    // Method to get user display info
    func getDisplayInfo() -> String {
        return "User: \(name)"
    }
    
    mutating func updatePoints(by amount: Int) {
        self.points += amount
    }
    
    // method to convert color string to UIColor
    func getColor(from colorName: String) -> Color {
        switch colorName.lowercased() {
        case "red": return .red
        case "green": return .green
        case "blue": return .blue
        case "orange": return .orange
        case "yellow": return .yellow
        case "purple": return .purple
        default: return .gray // Default color
        }
    }
}

// test cases
let users: [User] = [
    User(name: "David", profilePicture: "profilePicture", color: "red"),
    User(name: "Chris", profilePicture: "imageDog", color: "green"),
    User(name: "Ruben", profilePicture: "profilePicture"),
    User(name: "Manny", profilePicture: "profilePicture"),
]

