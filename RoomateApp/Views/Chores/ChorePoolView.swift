//
//  ChorePoolView.swift
//  iExpense
//
//  Created by David Abundis & Chris Nastasi on 3/27/25.
//

import SwiftUI

struct ChorePoolView: View {
    @State private var isPresentingAddChore = false
    @EnvironmentObject var authManager: AuthManager
    @StateObject var choreManager = ChoreManager()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(choreManager.chores) { chore in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(chore.title)
                            if let currentUser = authManager.currentUser, chore.assignedTo == currentUser.name {
                                Text("You")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            } else {
                                Text(chore.assignedTo)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Text("Points: \(chore.points)")
                                .font(.footnote)
                                .foregroundColor(.blue)
                        }
                        Spacer()
                        Button(action: {
                            _ = choreManager.completeChore(id: chore.id)
                        }) {
                            Text(chore.isCompleted ? "Complete" : "Incomplete")
                                .font(.caption)
                                .padding(5)
                                .background(chore.isCompleted ? Color.green : Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                        }
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        if index < choreManager.chores.count {
                            choreManager.removeChore(id: choreManager.chores[index].id)
                        }
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
                AddChoreView { chore, points, assignedTo in
                    choreManager.addChore(title: chore, points: points, assignedTo: assignedTo)
                }
                .environmentObject(authManager)
            }
        }
    }
}

#Preview {
    ChorePoolView()
        .environmentObject(AuthManager(autoLogin: true))
}
