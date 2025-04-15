//
//  ProfileView.swift
//  RoomateApp
//
//  Created by David Abundis on 3/13/25.
//

import SwiftUI

struct ProfileView: View {
    let backgroundGradient = LinearGradient(
        colors: [Color.green, Color.purple],
        startPoint: .top, endPoint: .bottom)
    
    @State private var notifications = true
    @State private var currentUser = users[0]
    var body: some View {
        ZStack{
            backgroundGradient
            VStack {
                HStack{
                    VStack{
                        Image("profilePicture")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(.circle)
                            .frame(width: 125, height: 125)
                            .padding()
                        Text("\(currentUser.name)")
                            .font(.largeTitle)
                            .foregroundStyle(Color.white)
                    }
                    Rectangle()
                            .fill(Color.white)
                            .frame(width: 10)
                            .padding(.vertical, 10)
                            .overlay(
                                Rectangle()
                                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [1]))
                                    .foregroundColor(.white)
                            )
                    
                    VStack{
                        Text("\(currentUser.points)")
                        Text("PTS")
                    }
                    .font(.title)
                    .foregroundStyle(Color.white)
                    .fontDesign(.rounded)
                    .padding()
                }
                NavigationStack{
                    Form{
                        Section("Nickname (Tap to edit)"){
                            TextField("\(currentUser.name)", text: $currentUser.name)
                                .foregroundStyle(Color.black)
                        }
                        Section("Notifications"){
                            Toggle(isOn: $notifications) {
                                Text("Chore Alerts")
                            }
                        }
                        
                        Section("Users"){
                            ForEach(users, id: \.self) { user in
                                Text(user.name)
                            }
                        }
                        Text("Logout")
                            .foregroundStyle(Color.red)
                        Section("Version"){
                            Text("1.0")
                        }
                    }
                    .navigationTitle("Settings").navigationBarTitleDisplayMode(.automatic)
                }
                .frame(width: 350, height: 510)
                .cornerRadius(20)
                
                
            }
            .padding()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ProfileView()
}
