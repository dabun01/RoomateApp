//
//  ChoreListView.swift
//  RoomateApp
//
//  Created by David Abundis & Chris Nastasi on 3/13/25.
//

import SwiftUI

struct ChoreListView: View {
    @State private var completedItems: [String: Bool] = [:]
    @State private var isPresentingAddChore: Bool = false
    let chores = ["Do the dishes", "Take out the trash", "Vacuum the living room", "Laundry", "Clean the bathroom"]
    let names = ["David", "Chris", "Ruben", "You", "You"]
    let points = [10, 20, 15, 25, 10]
    var onChoreCompleted: (Int) -> Void

    var body: some View {
        
        NavigationView {
            let filteredChores = Array(zip(chores.indices, zip(chores, names)))
                            .filter { $0.1.1 == "You" }
            List(filteredChores, id: \.0) { index, pair in
                let (chore, name) = pair
                HStack {
                    VStack(alignment: .leading) {
                        Text(chore)
                        Text(name)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("Points: \(points[index])")
                            .font(.footnote)
                            .foregroundColor(.blue)
                    }
                    Spacer()
                    Button(action: {
                        if completedItems[chore] == true {
                            completedItems[chore] = false
                            onChoreCompleted(-points[index])// Subtract points
                        } else {
                            completedItems[chore] = true
                            onChoreCompleted(points[index])// Add points to user
                        }
                    }) {
                        Text(completedItems[chore] ?? false ? "Complete" : "Incomplete")
                            .font(.caption)
                            .padding(5)
                            .background(completedItems[chore] ?? false ? Color.green : Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    }
                }
            }
        }
    }
}

#Preview {
    ChoreListView(onChoreCompleted: { points in
        print("Chore completed! Points awarded: \(points)")
    })
}
