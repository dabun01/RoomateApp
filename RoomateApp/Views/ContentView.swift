//
//  ContentView.swift
//  RoomateApp
//
//  Created by David Abundis & Chris Nastasi on 3/11/25.
//


// need to add database connections
// need to add login state
// need to add user state



//  ContentView.swift
//  RoomateApp
//
//  Created by David Abundis & Chris Nastasi on 3/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showProfileSettings: Bool = false
    @EnvironmentObject var authManager: AuthManager

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
                Divider()
                    .padding(.horizontal)
                .sheet(isPresented: $showProfileSettings) {
                    if authManager.isLoggedIn {
                        ProfileView()
                    } else {
                        LoginView()
                    }
                }

                if authManager.isLoggedIn, let currentUser = authManager.currentUser {
                    // Content for logged-in users

                    // Welcome and points
                    VStack(spacing: 10) {
                        HStack {
                            Text("Welcome, \(currentUser.name)!")
                                .font(.title2)
                                .fontWeight(.medium)
                                .padding(.leading)
                            Spacer()
                            Text("\(currentUser.points) pts")
                                .font(.title2)
                                .fontWeight(.medium)
                                .padding(.trailing)
                        }
                        HStack {
                            Spacer()
                            
                            
                        }
                        
                        .padding(.horizontal)
                    }

                    // Chore list
                    ScrollView {
                        VStack() {
                            Text(Date.now, style: .date)
                                .font(.title3)
                                .foregroundColor(.black)
                            Spacer()
                            
                        }

                        ChoreListView(onChoreCompleted: { points in
                            authManager.updateUserPoints(additionalPoints: points)
                        })
                    }

                    NavigationLink(destination: ChorePoolView()) {
                        Text("All Chores")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.horizontal)

                    // Roomies section
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Your Roomies")
                            .font(.title2)
                            .fontWeight(.medium)
                            .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 10) {
                                // Display each user in a horizontal list
                                ForEach(authManager.allUsers, id: \.name) { user in
                                            UserRow(user: user)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical, 20)
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                } else {
                    // Content for non-logged in users
                    VStack(spacing: 30) {
                        Image("app-logo") // Replace with your app logo or an appropriate image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 150, height: 150)
                            .padding(.top, 50)

                        Text("Welcome to Responsible Roomies")
                            .font(.title2)
                            .fontWeight(.bold)

                        Text("Manage chores and keep track of responsibilities with your roommates")
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        Button(action: {
                            showProfileSettings = true
                        }) {
                            Text("Sign In")
                                .frame(width: 200)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.top, 20)

                        Spacer()
                    }
                    .padding()
                }
            }
            .padding(.vertical)
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
                    .frame(width: 80, height: 80)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color(user.getColor(from: user.color ?? "blue")), lineWidth: 3)
                    )
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.gray)
            }

            Text(user.name)
                .font(.headline)
            Text("\(user.points) pts")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
    }
}

//moved to AuthManager.swift
//// Ensure the AuthManager has necessary functionality:
//extension AuthManager {
//    func updateUserPoints(additionalPoints: Int) {
//        if var user = currentUser {
//            user.points += additionalPoints
//            self.currentUser = user
//            
//            // Also update the user in the allUsers array
//            if let index = allUsers.firstIndex(where: { $0.name == user.name }) {
//                allUsers[index].points = user.points
//            }
//            self.objectWillChange.send()
//        }
//    }
//}

#Preview {
    ContentView()
        .environmentObject(AuthManager(autoLogin: true))
}
