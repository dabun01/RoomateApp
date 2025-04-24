//
//  AuthManager.swift
//  RoomateApp
//
//  Created by Christopher Nastasi on 4/24/25.
//

// This class is used to manage user authentication and login state.
// creates test user on app startup (David)

import Observation
import Foundation

class AuthManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var currentUser: User? = nil

    init() {
        // First try to load any existing user
//        loadSavedUser()

        // For testing only - uncomment to reset to test user
         createAndSaveTestUser()

        // For Testing Only -- create a household
        let household = Household(name: "Roommates", members: users)
        print("Household created: \(household.name) with members: \(household.members.map { $0.name })")
    }

    private func loadSavedUser() {
        if let userData = UserDefaults.standard.data(forKey: "currentUser") {
            do {
                let decoder = JSONDecoder()
                let user = try decoder.decode(User.self, from: userData)
                self.currentUser = user
                self.isLoggedIn = true
                print("Successfully loaded user: \(user.name)")
            } catch {
                print("Failed to decode user data: \(error.localizedDescription)")
                UserDefaults.standard.removeObject(forKey: "currentUser")
            }
        }
    }

    private func createAndSaveTestUser() {
        let testUser = User(
            name: "David",
            email: "david@rmapp.com",
            password: "password",
            profilePicture: "profilePicture",
            points: 10,
            color: "red"
        )

        do {
            let encoder = JSONEncoder()
            let userData = try encoder.encode(testUser)
            UserDefaults.standard.set(userData, forKey: "currentUser")
//            self.currentUser = testUser
//            self.isLoggedIn = true
            print("Test user saved successfully")
            print("Test user: \(testUser.name)")
        } catch {
            print("Failed to save test user: \(error.localizedDescription)")
        }
    }

    func login(user: User) {
        self.currentUser = user
        self.isLoggedIn = true
        saveCurrentUser()
    }

    func signUp(user: User) {
        self.currentUser = user
        self.isLoggedIn = true
        saveCurrentUser()
    }

    func logout() {
        self.currentUser = nil
        self.isLoggedIn = false
        UserDefaults.standard.removeObject(forKey: "currentUser")
    }

    private func saveCurrentUser() {
        if let user = currentUser {
            do {
                let encoder = JSONEncoder()
                let userData = try encoder.encode(user)
                UserDefaults.standard.set(userData, forKey: "currentUser")
                print("User saved successfully: \(user.name)")
            } catch {
                print("Failed to save user: \(error.localizedDescription)")
            }
        }
    }
}
//// First, create an AuthManager class to handle login state
//class AuthManager: ObservableObject {
//    @Published var isLoggedIn: Bool = false
//    @Published var currentUser: User? = nil
//
//    init() {
//        let testUser = User(
//            name: "David",
//            email: "david@rmapp.com", profilePicture: "profilePicture",
//            points: 10,
//            color: "red"
//        )
////        UserDefaults.standard.set(try? JSONEncoder().encode(testUser), forKey: "currentUser")
//        print(testUser)
//        // Check if the user is already logged in
////        if let userData = UserDefaults.standard.data(forKey: "currentUser"),
////           let user = try? JSONDecoder().decode(User.self, from: userData) {
////            self.currentUser = user
////            self.isLoggedIn = true
////        } else {
////            self.isLoggedIn = false
////        }
//    }
//
//    func login(user: User) {
//        self.currentUser = user
//        self.isLoggedIn = true
//    }
//
//    func signUp(user: User) {
//        // Here you would typically handle user sign-up logic
//        self.currentUser = user
//        self.isLoggedIn = true
//        UserDefaults.standard.set(user, forKey: "currentUser")
//
//    }
//
//    func logout() {
//        self.currentUser = nil
//        self.isLoggedIn = false
//    }
//
//}
