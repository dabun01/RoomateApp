//
//  ChoreManager.swift
//  RoomateApp
//
//  Created by David Abundis on 3/13/25.
//

import Foundation

// Define the Chore structure
struct Chore: Identifiable {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
    var dueDate: Date?
    
    // Method to toggle completion status
    mutating func toggleCompletion() {
        isCompleted.toggle()
    }
}

// Class to manage the chores list
class ChoreManager {
    // Mutable array of chores
    private(set) var chores: [Chore] = []
    
    // Add a new chore to the list
    func addChore(title: String, dueDate: Date? = nil) {
        let newChore = Chore(title: title, isCompleted: false, dueDate: dueDate)
        chores.append(newChore)
    }
    
    // Remove a chore by its ID
    func removeChore(id: UUID) {
        if let index = chores.firstIndex(where: { $0.id == id }) {
            chores.remove(at: index)
        }
    }
    
    // Update an existing chore
    func updateChore(id: UUID, newTitle: String? = nil, isCompleted: Bool? = nil, dueDate: Date? = nil) {
        if let index = chores.firstIndex(where: { $0.id == id }) {
            var updatedChore = chores[index]
            
            if let newTitle = newTitle {
                updatedChore.title = newTitle
            }
            
            if let isCompleted = isCompleted {
                updatedChore.isCompleted = isCompleted
            }
            
            if let dueDate = dueDate {
                updatedChore.dueDate = dueDate
            }
            
            chores[index] = updatedChore
        }
    }
    
    // Toggle completion status of a chore
    func toggleChoreCompletion(id: UUID) {
        if let index = chores.firstIndex(where: { $0.id == id }) {
            var chore = chores[index]
            chore.toggleCompletion()
            chores[index] = chore
        }
    }
    
    // Get all incomplete chores
    func getIncompleteChores() -> [Chore] {
        return chores.filter { !$0.isCompleted }
    }
    
    // Get all completed chores
    func getCompletedChores() -> [Chore] {
        return chores.filter { $0.isCompleted }
    }
}
