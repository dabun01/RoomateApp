//
//  ChoreManager.swift
//  RoomateApp
//
//  Created by David Abundis & Chris Nastasi on 3/13/25.
//

//  This file is used to manage the chores in the application.

import Foundation
import Observation


// Class to manage the chores list made it an ObservableObject to allow for SwiftUI updates\
// so it all refrences the same object

class ChoreManager: ObservableObject {
    @Published var chores: [Chore] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(chores) {
                UserDefaults.standard.set(encoded, forKey: "chores")
            }
        }
    }
    
    init() {
        if let savedChores = UserDefaults.standard.data(forKey: "chores") {
            if let decodedChores = try? JSONDecoder().decode([Chore].self, from: savedChores) {
                chores = decodedChores
                return
            }
        }
        
        // Default chores if none were loaded
        chores = [
            Chore(title: "Wash Dishes", points: 10),
            Chore(title: "Sweep The Living Room", points: 20),
            Chore(title: "Clean Counters", points: 15),
            Chore(title: "Deep Clean Bathroom", points: 25)
        ]
    }
    
    func updateChore(id: UUID, title: String, points: Int, assignedTo: String) {
        if let index = chores.firstIndex(where: { $0.id == id }) {
            chores[index].title = title
            chores[index].points = points
            chores[index].assignedTo = assignedTo
        }
    }
    
    // Add a new chore
    func addChore(title: String, points: Int, assignedTo: String) {
        let newChore = Chore(title: title, points: points, assignedTo: assignedTo)
        chores.append(newChore)
    }
    
    // Remove a chore
    func removeChore(id: UUID) {
        if let index = chores.firstIndex(where: { $0.id == id }) {
            chores.remove(at: index)
        }
    }
    
    // Complete a chore and return points
    func completeChore(id: UUID) -> Int {
        if let index = chores.firstIndex(where: { $0.id == id }) {
            var chore = chores[index]
            chore.toggleCompletion()
            chores[index] = chore
            return chore.points
        }
        return 0
    }
    
    // Get incomplete chores
    func getIncompleteChores() -> [Chore] {
        return chores.filter { !$0.isCompleted }
    }
    
    // Get completed chores
    func getCompletedChores() -> [Chore] {
        return chores.filter { $0.isCompleted }
    }
}
