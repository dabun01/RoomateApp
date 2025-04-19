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

    var onSave: (String, Int) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Chore Details")) {
                    TextField("Chore Name", text: $choreName)
                    Stepper(value: $points, in: 0...100, step: 5) {
                        Text("Points: \(points)")
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
                            onSave(choreName, points) // Pass the chore back to the parent view
                            dismiss()
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    AddChoreView { chore, points in
        print("Chore: \(chore), Points: \(points)")
    }
}
