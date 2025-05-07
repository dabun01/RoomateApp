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
    @Published var allUsers: [User] = [] // This should be replaced with a database call


    init(autologin: Bool = false) {
        if autologin != true {

            // comment this out if not working properly when autologin is on
            Task {
                let session = try await AuthManagerAW.shared.getSession()
                if session.current != false {
                    print("Session already active")
                    self.isLoggedIn = true
                    createAndSaveTestUser()
                    self.currentUser = UserDefaults.standard.object(forKey: "currentUser") as? User
                } else {
                    self.isLoggedIn = false
                    self.currentUser = nil
                }
            }
        }

        // For testing only - uncomment to reset to test user
//         createAndSaveTestUser()

        // For Testing Only -- create a household
        let household = Household(name: "Roommates", members: users)
        print("Household created: \(household.name) with members: \(household.members.map { $0.name })")
    }

    // for testing only
    convenience init(autoLogin: Bool = false) {
        self.init()
        if autoLogin {
            self.isLoggedIn = true
            // Create test user data
            createTestUsers()

            // Set the first user as current user
            if !self.allUsers.isEmpty {
                self.currentUser = self.allUsers[0]
            }
        }
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
    private func createTestUsers() {
        self.allUsers = [
            User(name: "David", profilePicture: "profilePicture", points: 50, color: "red"),
            User(name: "Chris", profilePicture: "imageDog", points: 30, color: "green"),
            User(name: "Ruben", profilePicture: "profilePicture", points: 20, color: "blue"),
            User(name: "Manny", profilePicture: "profilePicture", points: 40, color: "orange")
        ]
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
//        Appwrite.shared.user = user
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
        Task {{
            do {
                try await AuthManagerAW.shared.signOut()
                print("User signed out successfully")
            } catch {
                print("Error signing out: \(error.localizedDescription)")
            }
        }}
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
    // Function to update user points
    func updateUserPoints(additionalPoints: Int) {
        if var user = currentUser {
            user.points += additionalPoints
            self.currentUser = user
            
            // Also update the user in the allUsers array
            if let index = allUsers.firstIndex(where: { $0.name == user.name }) {
                allUsers[index].points = user.points
            }
            self.objectWillChange.send()
        }
    }
}
