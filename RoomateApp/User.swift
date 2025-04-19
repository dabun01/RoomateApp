//
//  User.swift
//  RoomateApp
//
//  Created by David Abundis on 4/10/25.
//

import Foundation
import SwiftUI
import UIKit

struct User: Hashable, Codable {
    // Properties
    var name: String
    var profilePicture: String?
    var points: Int = nil as Int? ?? 0
    
    // Method to get user display info
    func getDisplayInfo() -> String {
        return "User: \(name)"
    }
}

let users: [User] = [
    User(name: "David", profilePicture: "profilePicture"),
    User(name: "Chris", profilePicture: "imageDog"),
    User(name: "Ruben", profilePicture: "profilePicture"),
    User(name: "Manny", profilePicture: "profilePicture")
]

