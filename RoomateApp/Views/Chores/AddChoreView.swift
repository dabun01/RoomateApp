//
//  AddChoreView.swift
//  RoomateApp
//
//  Created by Christopher Nastasi & David Abundis on 4/19/25.
//

import SwiftUI

struct AddChoreView: View {
    @Environment(\.dismiss) var dismiss
    @State private var choreName: String = ""
    @State private var points: Int = 0
    @State private var assignedUserName: String = "Unassigned"
    @EnvironmentObject var authManager: AuthManager
    
    var onSave: (String, Int, String) -> Void
    
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
                            }else{
                                Text(user.name).tag(user.name)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Add Chore")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if !choreName.isEmpty {
                            onSave(choreName, points, assignedUserName) // Pass the chore back to the parent view
                            dismiss()
                        }
                    }
                }
            }
            .onAppear {
                if let currentUser = authManager.currentUser {
                    assignedUserName = currentUser.name
                }
            }
        }
    }
}


#Preview {
    AddChoreView { chore, points, assignedTo in
        print("Chore: \(chore), Points: \(points), Assigned To: \(assignedTo)")
    }
    .environmentObject(AuthManager(autoLogin: true))
}
