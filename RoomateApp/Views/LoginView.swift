//
//  LoginView.swift
//  RoomateApp
//
//  Created by Christopher Nastasi & David Abundis on 4/19/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Environment(\.dismiss) private var dismiss
    @State private var showError = false
    @State private var errorMessage = ""
    @State private var isLoginMode = true

    var body: some View {
        NavigationStack {
           VStack(spacing: 20) {
               Image("logo")
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 350, height: 100)
               Text("Responsible Roomies")
                   .font(.title)
                   .foregroundStyle(.black)
                   .fontDesign(.monospaced)
                   .padding(.horizontal)
               // Toggle between Login and Sign-Up
               Picker(selection: $isLoginMode, label: Text("Mode")) {
                   Text("Login").tag(true)
                   Text("Sign Up").tag(false)
               }
               .pickerStyle(SegmentedPickerStyle())
               .padding()

               // Email field
               TextField("Username", text: $username)
                   .keyboardType(.emailAddress)
                   .autocapitalization(.none)
                   .padding()
                   .background(Color.gray.opacity(0.2))
                   .cornerRadius(8)

               // Password field
               SecureField("Password", text: $password)
                   .padding()
                   .background(Color.gray.opacity(0.2))
                   .cornerRadius(8)

               // Confirm password field (only for sign-up)
               if !isLoginMode {
                   SecureField("Confirm Password", text: $confirmPassword)
                       .padding()
                       .background(Color.gray.opacity(0.2))
                       .cornerRadius(8)
               }

               // Error message
               if !errorMessage.isEmpty {
                   Text(errorMessage)
                       .foregroundColor(.red)
                       .font(.footnote)
               }

               // Submit button
               Button(action: {
                     if isLoginMode {
                        attemptLogin()
                     } else {
                        attemptSignUp()

                     }
               }) {
                   Text(isLoginMode ? "Login" : "Sign Up")
                       .frame(maxWidth: .infinity)
                       .padding()
                       .background(Color.blue)
                       .foregroundColor(.white)
                       .cornerRadius(8)
               }
               .padding(.top)
               Spacer()
           }
           .padding()
           .navigationTitle(isLoginMode ? "Login" : "Sign Up")
           .background(
               LinearGradient(
                   gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.2)]),
                   startPoint: .top,
                   endPoint: .bottom
               )
               .ignoresSafeArea()
           )
        }
    }

    private func attemptLogin() {
        // Simple validation - in a real app you would check against a database

        if let user = findUser(name: username, password: password) {
            print(user)
            authManager.login(user: user)
            dismiss()
        } else {
            showError = true
            errorMessage = "Invalid username or password"
        }
    }

    private func attemptSignUp() {
        // Validate passwords match
        if password != confirmPassword {
            showError = true
            errorMessage = "Passwords don't match"
            return
        }

        // Check if username already exists
        if users.contains(where: { $0.name.lowercased() == username.lowercased() }) {
            showError = true
            errorMessage = "Username already exists"
            return
        }

        // Create new user
        let newUser = User(
            name: username,
            profilePicture: nil,
            points: 0,
            color: "blue"
        )

        // In a real app, you would save this user to your database
        // For this demo, we'll just log in with the new user
        authManager.login(user: newUser)

        // In a real implementation, you would save the new user to your persistence layer
        // users.append(newUser)  // This would be replaced with proper database operation

        dismiss()
    }

    private func findUser(name: String, password: String) -> User? {
        // This is a simplified example - in a real app, you would validate against
        // a secured authentication system, not an in-memory array
        return users.first { user in
            user.name.lowercased() == username.lowercased() &&
            // In a real app, you'd check a hashed password, not plaintext
            // This is just for demonstration
            password == "password" // Simplified for example
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthManager())
}
//import SwiftUI
//
//struct LoginView: View {
//    @EnvironmentObject var authManager: AuthManager
//    @State private var username: String = ""
//    @State private var password: String = ""
//    @State private var confirmPassword: String = ""
//    @Environment(\.dismiss) private var dismiss
//    @State private var showError = false
//    @State private var errorMessage = ""
//    @State private var isLoginMode = true

//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 20) {
//                Image("logo")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 350, height: 100)
//                Text("Responsible Roomies")
//                    .font(.title)
//                    .foregroundStyle(.black)
//                    .fontDesign(.monospaced)
//                    .padding(.horizontal)
//                // Toggle between Login and Sign-Up
//                Picker(selection: $isLoginMode, label: Text("Mode")) {
//                    Text("Login").tag(true)
//                    Text("Sign Up").tag(false)
//                }
//                .pickerStyle(SegmentedPickerStyle())
//                .padding()
//
//                // Email field
//                TextField("Email", text: $email)
//                    .keyboardType(.emailAddress)
//                    .autocapitalization(.none)
//                    .padding()
//                    .background(Color.gray.opacity(0.2))
//                    .cornerRadius(8)
//
//                // Password field
//                SecureField("Password", text: $password)
//                    .padding()
//                    .background(Color.gray.opacity(0.2))
//                    .cornerRadius(8)
//
//                // Confirm password field (only for sign-up)
//                if !isLoginMode {
//                    SecureField("Confirm Password", text: $confirmPassword)
//                        .padding()
//                        .background(Color.gray.opacity(0.2))
//                        .cornerRadius(8)
//                }
//
//                // Error message
//                if !errorMessage.isEmpty {
//                    Text(errorMessage)
//                        .foregroundColor(.red)
//                        .font(.footnote)
//                }
//
//                // Submit button
//                Button(action: handleAction) {
//                    Text(isLoginMode ? "Login" : "Sign Up")
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(8)
//                }
//                .padding(.top)
//                Spacer()
//                // Test User Button
//                Button(action: testUserMode) {
//                    Text("Use Test User")
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(8)
//                }
//                .padding(.top)
//                Spacer()
//            }
//            .padding()
//            .navigationTitle(isLoginMode ? "Login" : "Sign Up")
//            .background(
//                LinearGradient(
//                    gradient: Gradient(colors: [Color.white, Color.blue.opacity(0.2)]),
//                    startPoint: .top,
//                    endPoint: .bottom
//                )
//                .ignoresSafeArea()
//            )
//        }
//    }
//
//    private func handleAction() {
//        if isLoginMode {
//            // Handle login logic
//            if email.isEmpty || password.isEmpty {
//                errorMessage = "Please fill in all fields."
//            } else {
//                errorMessage = ""
//                // Perform login
//                print("Directing to HomeView")
//                
//
//                // Navigate to HomeView
//                isLoggedIn = true
//
//            }
//        } else {
//            // Handle sign-up logic
//            if email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
//                errorMessage = "Please fill in all fields."
//            } else if password != confirmPassword {
//                errorMessage = "Passwords do not match."
//            } else {
//                errorMessage = ""
//                // Perform sign-up
//
//            }
//        }
//    }
//
//    private func attemptLogin() {
//        // Simple validation - in a real app you would check against a database
//        if let user = findUser(username: username, password: password) {
//            authManager.login(user: user)
//            dismiss()
//        } else {
//            showError = true
//            errorMessage = "Invalid username or password"
//        }
//    }
//
//    private func attemptSignUp() {
//        // Validate passwords match
//        if password != confirmPassword {
//            showError = true
//            errorMessage = "Passwords don't match"
//            return
//        }
//
//        // Check if username already exists
//        if users.contains(where: { $0.name.lowercased() == username.lowercased() }) {
//            showError = true
//            errorMessage = "Username already exists"
//            return
//        }
//
//        // Create new user
//        let newUser = User(
//            name: username,
//            profilePicture: nil,
//            points: 0,
//            color: "blue"
//        )
//
//        // In a real app, you would save this user to your database
//        // For this demo, we'll just log in with the new user
//        authManager.login(user: newUser)
//
//        // In a real implementation, you would save the new user to your persistence layer
//        // users.append(newUser)  // This would be replaced with proper database operation
//
//        dismiss()
//    }
//
//    private func findUser(username: String, password: String) -> User? {
//        // This is a simplified example - in a real app, you would validate against
//        // a secured authentication system, not an in-memory array
//        return users.first { user in
//            user.name.lowercased() == username.lowercased() &&
//            // In a real app, you'd check a hashed password, not plaintext
//            // This is just for demonstration
//            password == "password" // Simplified for example
//        }
//    }
//}
//
//#Preview {
//    LoginView()
//}
