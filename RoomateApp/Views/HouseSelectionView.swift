//
//  HouseSelectionView.swift
//  RoomateApp
//
//  Created by Christopher Nastasi on 4/20/25.
//

import SwiftUI

struct HouseholdSelectionView: View {
    @State private var householdId = UUID()
    @State private var householdName = ""
    @State private var isJoiningExisting = false
    @State private var household: Household?

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome!")
                .font(.largeTitle)
                .padding()

            if isJoiningExisting {
                TextField("Enter Household Name", text: $householdName)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                Button("Join Household") {
                    joinHousehold()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            } else {
                TextField("Create New Household Name", text: $householdName)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                Button("Create Household") {
                    createHousehold()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
            }

            Button(isJoiningExisting ? "Switch to Create" : "Switch to Join") {
                isJoiningExisting.toggle()
            }
            .foregroundColor(.blue)
        }
        .padding()
    }

    private func createHousehold() {
        household = Household(name: householdName)
        print("Created household: \(household?.name ?? "") with ID: \(household?.id.uuidString ?? "")")
    }

    private func joinHousehold() {
        // Simulate joining an existing household
        household = Household(name: householdName)
        print("Joined household: \(household?.name ?? "") with ID: \(household?.id.uuidString ?? "")")
    }
}

#Preview {
    HouseholdSelectionView()
}
