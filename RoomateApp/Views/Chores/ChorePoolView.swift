//
//  ChorePoolView.swift
//  iExpense
//
//  Created by David Abundis & Chris Nastasi on 3/27/25.
//

import SwiftUI

struct ChorePoolView: View {
    @State private var completedItems: [String: Bool] = [:]
    @State private var isPresentingAddChore = false
    @State private var chores: [(item: String, name: String, points: Int)] = [
        ("Wash Dishes", "David", 10),
        ("Sweep The Living Room", "Chris", 20),
        ("Clean Counters", "Ruben", 15),
        ("Deep Clean Bathroom", "You", 25)
    ]

    var body: some View {
        NavigationView {
            List(chores.indices, id: \.self) { index in
                let chore = chores[index]
                HStack {
                    VStack(alignment: .leading) {
                        Text(chore.item)
                        Text(chore.name)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Text("Points: \(chore.points)")
                            .font(.footnote)
                            .foregroundColor(.blue)
                    }
                    Spacer()
                    Button(action: {
                        completedItems[chore.item] = !(completedItems[chore.item] ?? false)
                    }) {
                        Text(completedItems[chore.item] ?? false ? "Complete" : "Incomplete")
                            .font(.caption)
                            .padding(5)
                            .background(completedItems[chore.item] ?? false ? Color.green : Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    }
                }
            }
            .navigationTitle("Chore Pool")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isPresentingAddChore = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isPresentingAddChore) {
                AddChoreView { chore, points in
                    chores.append((item: chore, name: "You", points: points))
                }
            }
        }
    }
}

#Preview {
    ChorePoolView()
}
