//
//  ContentView.swift
//  RoomateApp
//
//  Created by David Abundis on 3/11/25.
//

// Scoring system for doing chores

import SwiftUI

import UIKit

struct User {
    // Properties
    var name: String
    var profilePicture: UIImage?
    
    // Method to update profile picture
    mutating func updateProfilePicture(newImage: UIImage) {
        self.profilePicture = newImage
    }
    
    // Method to get user display info
    func getDisplayInfo() -> String {
        return "User: \(name)"
    }
}

let users: [User] = [
    User(name: "David", profilePicture: UIImage(named: "profilePicture")),
    User(name: "Chris", profilePicture: nil),
    User(name: "Ruben", profilePicture: UIImage(named: "profilePicture")),
    User(name: "Manny", profilePicture: UIImage(named: "profilePicture"))
]

struct ContentView: View {
    @State private var showProfileSettings: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack() {
                Text ("Your Household")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                Spacer()
                Button(action: {
                    showProfileSettings.toggle()
                }) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.blue)
                        .padding()
                }
            }.sheet(isPresented: $showProfileSettings){
                ProfileView()
            }
            
            HStack(spacing: 30){
                ForEach(users, id: \.name) { user in
                    UserRow(user: user)
                }
            }
            .frame(maxWidth: 400)
            .padding(.vertical, 40)
            .background(.regularMaterial)
            .clipShape(.rect)
            .background(Color.blue)
        }
        ChoreListView()
        
    }
}


struct UserRow: View {
    let user: User
    
    var body: some View {
        VStack {
            if let profileImage = user.profilePicture {
                Image(uiImage: profileImage)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.gray)
            }
            
            Text(user.name)
                .font(.headline)
            
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ContentView()
}
