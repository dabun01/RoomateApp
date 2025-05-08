//
//  ChorePoolView.swift
//  iExpense
//
//  Created by David Abundis & Chris Nastasi on 3/27/25.
//

import SwiftUI

struct ChorePoolView: View {
    @State private var isPresentingAddChore = false
    @State private var choreToEdit: Chore? = nil
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var choreManager: ChoreManager  
    
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
                    .swipeActions(edge: .leading) {
                        Button {
                            choreToEdit = chore
                        } label: {
                            Label("Edit", systemImage: "pencil")
                        }
                        .tint(.blue)
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
            .sheet(item: $choreToEdit) { chore in
                EditChoreView(chore: chore) { updatedTitle, updatedPoints, updatedAssignee in
                    choreManager.updateChore(
                        id: chore.id,
                        title: updatedTitle,
                        points: updatedPoints,
                        assignedTo: updatedAssignee
                    )
                }
                .environmentObject(authManager)
            }
        }
    }
}

struct EditChoreView: View {
    @Environment(\.dismiss) var dismiss
    @State private var choreName: String
    @State private var points: Int
    @State private var assignedUserName: String
    @EnvironmentObject var authManager: AuthManager

    let chore: Chore
    var onSave: (String, Int, String) -> Void

    init(chore: Chore, onSave: @escaping (String, Int, String) -> Void) {
        self.chore = chore
        self.onSave = onSave
        _choreName = State(initialValue: chore.title)
        _points = State(initialValue: chore.points)
        _assignedUserName = State(initialValue: chore.assignedTo)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Chore Details")) {
                    TextField("Chore Name", text: $choreName)
                    Stepper(value: $points, in: 0...100, step: 5) {
                        Text("Points: \(points)")
                    }
                    Picker("Assign To", selection: $assignedUserName) {
                        Text("Unassigned").tag("Unassigned")

                        ForEach(authManager.allUsers) { user in
                            if authManager.currentUser?.id == user.id {
                                Text("You").tag(user.name)
                            } else {
                                Text(user.name).tag(user.name)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Edit Chore")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if !choreName.isEmpty {
                            onSave(choreName, points, assignedUserName)
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ChorePoolView()
        .environmentObject(AuthManager(autoLogin: true))
        .environmentObject(ChoreManager())
}
