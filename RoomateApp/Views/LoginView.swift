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
                        Task {
                            await attemptLogin()
                        }
                     } else {
                         Task {
                             await attemptSignUp()
                         }
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

    private func attemptLogin() async {
        print("Attempting Login")

        do {
            let session = try await AuthManagerAW.shared.signIn(email: username, password: password)
            print("Login successful: \(session)")
            // Fetch current user
            let user = try await AuthManagerAW.shared.getCurrentUser()
            print("Current user: \(user)")
            authManager.isLoggedIn = true

            dismiss()
        } catch {
            showError = true
            errorMessage = "Invalid username or password"
            print("Login failed: \(error)")
        }
    }

    private func attemptSignUp() async {
        if password != confirmPassword {
            showError = true
            errorMessage = "Passwords don't match"
            return
        }

        do {
            try await AuthManagerAW.shared.signUp(email: username, password: password, name: username)
            print("Sign up successful")
            dismiss()
        } catch {
            showError = true
            errorMessage = "Sign-up failed"
            print("Sign-up failed: \(error)")
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthManager())
}
