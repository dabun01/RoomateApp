//
//  RoomateAppApp.swift
//  RoomateApp
//
//  Created by David Abundis on 3/11/25.
//

import SwiftUI

@main
struct RoomateAppApp: App {
    @StateObject var authManager = AuthManager(autoLogin: true) // Create an instance of AuthManager
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authManager) // Pass the AuthManager to the environment
        }
    }
}
