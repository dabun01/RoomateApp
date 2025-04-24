//
//  ChoreManager.swift
//  RoomateApp
//
//  Created by David Abundis & Chris Nastasi on 3/13/25.
//

//  This file is used to manage the chores in the application.

import Foundation
import Observation

// Define the Chore structure
struct Chore: Identifiable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
    var dueDate: Date?
    var points: Int
    
    // Method to toggle completion status
    mutating func toggleCompletion() {
        isCompleted.toggle()
    }
}

// Class to manage the chores list
@Observable
class ChoreManager {
    // Mutable array of chores
    var chores = [Chore](){
        didSet{
            if let encode = try? JSONEncoder().encode(chores){
                UserDefaults.standard.set(encode, forKey: "chores")
            }
        }
    }
    
    init() {
        if let savedChore = UserDefaults.standard.data(forKey: "chores"){
            if let decodedChore = try? JSONDecoder().decode([Chore].self, from: savedChore){
                chores = decodedChore
                return
            }
        }
        chores = []
    }
    
    // Add a new chore to the list
    func addChore(title: String, dueDate: Date? = nil) {
        let newChore = Chore(title: title, isCompleted: false, dueDate: dueDate, points: 10)
        chores.append(newChore)
    }
    
    // Remove a chore by its ID
    func removeChore(id: UUID) {
        if let index = chores.firstIndex(where: { $0.id == id }) {
            chores.remove(at: index)
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
