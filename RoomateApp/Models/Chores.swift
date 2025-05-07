//
//  Chores.swift
//  RoomateApp
//
//  Created by Christopher Nastasi on 5/6/25.
//

import Foundation
import Observation

// Define the Chore structure
struct Chore: Identifiable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
    var dueDate: Date?
    var points: Int
    var assignedTo: String = "Unassigned"

    // Method to toggle completion status
    mutating func toggleCompletion() {
        isCompleted.toggle()
    }
}
