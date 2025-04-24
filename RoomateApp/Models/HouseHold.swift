//
//  Untitled.swift
//  RoomateApp
//
//  Created by Christopher Nastasi & David Abundis on 4/19/25.
//

import Foundation
import Observation


struct Household: Hashable, Codable, Identifiable {
    let id: UUID
    var name: String
    var members: [User]

    var totalPoints: Int {
        members.reduce(0) { $0 + $1.points }
    }
    var prize: Int

    init(id: UUID = UUID(), name: String, members: [User] = []) {
        self.id = id
        self.name = name
        self.members = members
        self.prize = 100
    }
}

// Example usage
let household = Household(name: "Roommates", members: users)
