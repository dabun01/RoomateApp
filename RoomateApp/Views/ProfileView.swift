//
//  ProfileView.swift
//  RoomateApp
//
//  Created by David Abundis on 3/13/25.
//

import SwiftUI

struct ProfileView: View {
    let users: [User] = [
        User(name: "David", profilePicture: UIImage(named: "profilePicture")),
        User(name: "Chris", profilePicture: nil),
        User(name: "Ruben", profilePicture: UIImage(named: "profilePicture")),
        User(name: "Manny", profilePicture: UIImage(named: "profilePicture"))
    ]
    
    @State private var notifications = true
    
    
    
    var body: some View {
        VStack{
            VStack {
                Image("profilePicture")
                    .resizable()
                    .frame(width: 300, height: 300)
                Text("\(users[0].name)")
                    .font(.largeTitle)
            }

            NavigationStack{
                Form{
                    Text("Settings")
                    Text("Username: \(users[0].name)")
                    Text("Notifications")
                    Toggle(isOn: $notifications) {
                        Text("Notifications")
                    }
                    
                }
            }
            .navigationTitle("User Options")


        }
        .padding()
    }
}

#Preview {
    ProfileView()
}
