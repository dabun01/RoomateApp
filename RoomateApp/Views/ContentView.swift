//
//  ContentView.swift
//  RoomateApp
//
//  Created by David Abundis & Chris Nastasi on 3/11/25.
//

// Scoring system for doing chores

import SwiftUI

struct ContentView: View {
    @State private var showProfileSettings: Bool = false
    @State var currentUser = users[0]
    @State var isLoggedIn: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Title and navbar
                HStack {
                    Text("Responsible Roomies")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.leading)
                    Spacer()
                    Button(action: {
                        showProfileSettings.toggle()
                    }) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.blue)
                            .padding(.trailing)
                    }
                }
                .sheet(isPresented: $showProfileSettings) {
                    if isLoggedIn {
                        ProfileView()
                    } else {
                        LoginView()
                    }
                }

                // Welcome and points
                VStack(spacing: 10) {
                    HStack {
                        Text("Welcome \(currentUser.name)")
                            .font(.title2)
                            .fontWeight(.medium)
                        Spacer()
                        Text("\(currentUser.points) pts")
                            .font(.title2)
                            .fontWeight(.medium)
                    }
                    .padding(.horizontal)
                }

                // Chore list
                ScrollView {
                    ChoreListView()
                }
                .padding(.horizontal)

                // Roomies section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Your Roomies")
                        .font(.title2)
                        .fontWeight(.medium)
                        .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 20) {
                            ForEach(users, id: \.name) { user in
                                UserRow(user: user)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)
            }
            .padding(.top)
            .background(LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.2)]), startPoint: .top, endPoint: .bottom))
        }
    }
}

struct UserRow: View {
    let user: User

    var body: some View {
        VStack {
            if let profilePicture = user.profilePicture {
                Image(profilePicture)
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
            Text("\(user.points) pts")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ContentView()
}
