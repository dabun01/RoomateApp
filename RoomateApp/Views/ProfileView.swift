//
//  ProfileView.swift
//  RoomateApp
//
//  Created by David Abundis on 3/13/25.
//

import SwiftUI

struct ProfileView: View {
   
    @State private var notifications = true
    let currentUser = users[0]
    var body: some View {
        VStack{
            VStack {
                Image("profilePicture")
                    .resizable()
                    .frame(width: 300, height: 300)
                Text("\(currentUser.name)")
                    .font(.largeTitle)
            }
           
                NavigationStack{
                    Form{
                        Text("Username: \(currentUser.name)")
                        Toggle(isOn: $notifications) {
                            Text("Notifications")
                        }
                        Section("Users"){
                            ForEach(users, id: \.self) { user in
                                Text(user.name)
                            }
                        }
                    }
                    .navigationTitle("Settings")
                }
        }
        .padding()
    }
}

#Preview {
    ProfileView()
}
