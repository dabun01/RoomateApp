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
    var points: Int = 0
    
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
    User(name: "David", profilePicture: UIImage(named: "profilePicture"), points: 25),
    User(name: "Chris", profilePicture: nil, points: 30),
    User(name: "Ruben", profilePicture: UIImage(named: "profilePicture"), points: -10),
    User(name: "Manny", profilePicture: UIImage(named: "profilePicture"), points: 20)
]

struct ContentView: View {
    @State private var showProfileSettings: Bool = false
    
    var body: some View {
        // Title and navbar
        NavigationStack{
            HStack(){
                Text ("Responsible Roomies")
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
            }
            .background(Color.gray.opacity(0.1))
            .sheet(isPresented: $showProfileSettings){
                ProfileView()
            }
            VStack(){
                HStack() {
                    Text ("Welcome \(users[0].name)")
                        .font(.title)
                        .fontWeight(.medium)
                        .padding()
                    Spacer()
                    Text("\(users[0].points)pts")
                        .font(.title)
                        .fontWeight(.medium)
                        .padding()
                }
//                List{
//                    Section("Your Chores"){
//                        Text("Dishes")
//                        Text("Laundry")
//                        Text("Vacuuming")
//                        Text("Cleaning bathrooms")
//                        Text("Taking out the trash")
//                    }
//                }
//                .frame(maxHeight: 350)
                ChoreListView()
                Text("Your Roomies")
                    .font(.title)
                    .fontWeight(.medium)
                HStack(spacing: 30){
                    ForEach(users, id: \.name) { user in
                        UserRow(user: user)
                    }
                }
                .padding()
                .background(.regularMaterial)
                .clipShape(.rect)
                .background(Color.blue)
                .frame(maxHeight: 150)
            }
        }
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
            Text("\(user.points)pts")
            
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ContentView()
}
