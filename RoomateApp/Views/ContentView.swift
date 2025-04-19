//
//  ContentView.swift
//  RoomateApp
//
//  Created by David Abundis on 3/11/25.
//

// Scoring system for doing chores

import SwiftUI

import UIKit


struct ContentView: View {
    @State private var showProfileSettings: Bool = false
    @State var currentUser = users[0]
    
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
                    Text ("Welcome \(currentUser.name)")
                        .font(.title)
                        .fontWeight(.medium)
                        .padding()
                    Spacer()
                    Text("\(currentUser.points)pts")
                        .font(.title)
                        .fontWeight(.medium)
                        .padding()
                }
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
            if user.profilePicture != nil {
                Image("\(user.profilePicture!)")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color.black, lineWidth: 2)
                    )
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
