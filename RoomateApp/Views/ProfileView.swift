//
//  ProfileView.swift
//  RoomateApp
//
//  Created by David Abundis & Chris Nastasi on 3/13/25.
//

import SwiftUI

struct ProfileView: View {
    let backgroundGradient = LinearGradient(
        colors: [Color.blue, Color.white],
        startPoint: .top, endPoint: .bottom)
    
    @State private var notifications = true
    @State private var nickname = ""
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var choreManager: ChoreManager
    
    var body: some View {
        ZStack{
            backgroundGradient
            VStack {
                if let currentUser = authManager.currentUser {
                    HStack{
                        VStack{
                            if currentUser.profilePicture != nil {
                                Image("profilePicture")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(.circle)
                                    .frame(width: 125, height: 125)
                                    .padding()
                            } else {
                                Image("profilePicture")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(.circle)
                                    .frame(width: 125, height: 125)
                                    .padding()
                            }
                        }
                        
                        VStack{
                            Text(currentUser.name)
                                .font(.title)
                                .foregroundStyle(Color.white)
                            Text("\(currentUser.points) PTS")
                        }
                        .font(.title)
                        .foregroundStyle(Color.white)
                        .fontDesign(.rounded)
                        .padding()
                    }
                    NavigationStack{
                        Form{
                            Section("Nickname (Tap to edit)"){
                                TextField(currentUser.name, text: $nickname)
                                    .foregroundStyle(Color.black)
                                    .onAppear {
                                        nickname = currentUser.name
                                    }
                                    .onSubmit {
                                        if !nickname.isEmpty && nickname != currentUser.name {
                                            authManager.updateUserName(nickname)
                                        }
                                    }
                            }
                            Section("Notifications"){
                                Toggle(isOn: $notifications) {
                                    Text("Chore Alerts")
                                }
                            }
                            
                            Section("Users"){
                                ForEach(authManager.allUsers) { user in
                                    Text(user.id == currentUser.id ? "You" : user.name)
                                }
                            }
                            Button("Log Out"){
                                // Log out action
                                Task {
                                    try? await AuthManagerAW.shared.signOut()
                                }
                                authManager.logout()
                            }
                            .foregroundStyle(Color.red)
                            Section("Version"){
                                Text("1.0")
                            }
                        }
                        .navigationTitle("Settings").navigationBarTitleDisplayMode(.automatic)
                    }
                    .frame(width: 350, height: 510)
                    .cornerRadius(20)
                } else {
                    Text("Not logged in")
                        .foregroundStyle(Color.white)
                }
            }
            .padding()
        }
        .ignoresSafeArea()
        .onAppear {
            // Refresh user data when view appears
            if let currentUser = authManager.currentUser {
                nickname = currentUser.name
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthManager())
        .environmentObject(ChoreManager())
}
