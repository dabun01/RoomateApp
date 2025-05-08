//
//  AWAuthManager.swift
//  RoomateApp
//
//  Created by Christopher Nastasi on 5/6/25.
//


import Foundation
import Appwrite
import AppwriteModels


class AuthManagerAW {
    private let client: Client
    private let account: Account
    
    // User state
    @Published var currentUser: User?
    @Published var isLoggedIn: Bool = false

    // Singleton instance
    static let shared = AuthManagerAW()

    private init() {
        guard let endpoint_url = ProcessInfo.processInfo.environment["AW_URL"] else {
            fatalError("APPWRITE_ENDPOINT not set")
        }
        guard let project_id = ProcessInfo.processInfo.environment["AW_PID"] else {
            fatalError("APPWRITE_PROJECT not set")
        }
        // Initialize Appwrite client
        client = Client()
            .setEndpoint("https://fra.cloud.appwrite.io/v1") // Replace with your Appwrite endpoint
            .setProject("681aafe600208c1254d4") // Replace with your project ID

        // Initialize Account
        account = Account(client)
    }

    // Sign up with email and password
    func signUp(email: String, password: String, name: String) async throws {
        
        _ = try await account.create(userId: ID.unique(), email: email, password: password, name: name)
    }

    // Sign in with email and password
    func signIn(email: String, password: String) async throws -> Session {
        let session = try await account.createEmailPasswordSession(email: email, password: password)
//        UserDefaults.set(session.id, forKey: "sessionId")
        return session
    }

    func getSession() async throws -> Session {
        let session = try await account.getSession(sessionId: "current")
        return session
    }

    // Get current user
    func getCurrentUser() async throws -> Any {
        let currentUser =  try await account.get()
//        UserDefaults.set(currentUser.name, forKey: "currentUser")
        return currentUser

    }

    // Sign out
    func signOut() async throws {
        // Properly handle the return value
        let _ = try await account.deleteSession(sessionId: "current")
        
        // Clear local user data
        UserDefaults.standard.removeObject(forKey: "sessionId")
        isLoggedIn = false
        currentUser = nil
        
        print("User signed out successfully")
    }

    // Check if user is authenticated
    func isAuthenticated() async -> Bool {
        do {
            _ = try await account.get()
            return true
        } catch {
            return false
        }
    }
}
