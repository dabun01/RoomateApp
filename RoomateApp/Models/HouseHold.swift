//
//  Untitled.swift
//  RoomateApp
//
//  Created by Christopher Nastasi & David Abundis on 4/19/25.
//

import Foundation

struct Household: Identifiable {
    let id: UUID
    var name: String
    var members: [User]

    var totalPoints: Int {
        members.reduce(0) { $0 + $1.points }
    }

    init(id: UUID = UUID(), name: String, members: [User] = []) {
        self.id = id
        self.name = name
        self.members = members
    }
}
