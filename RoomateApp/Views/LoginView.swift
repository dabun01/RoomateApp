//
//  LoginView.swift
//  RoomateApp
//
//  Created by Christopher Nastasi & David Abundis on 4/19/25.
//

import SwiftUI

struct LoginView: View {
    @State private var isLoginMode = true
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Toggle between Login and Sign-Up
                Picker(selection: $isLoginMode, label: Text("Mode")) {
                    Text("Login").tag(true)
                    Text("Sign Up").tag(false)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                // Email field
                TextField("Email", text: $email)
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
                Button(action: handleAction) {
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

    private func handleAction() {
        if isLoginMode {
            // Handle login logic
            if email.isEmpty || password.isEmpty {
                errorMessage = "Please fill in all fields."
            } else {
                errorMessage = ""
                // Perform login
            }
        } else {
            // Handle sign-up logic
            if email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
                errorMessage = "Please fill in all fields."
            } else if password != confirmPassword {
                errorMessage = "Passwords do not match."
            } else {
                errorMessage = ""
                // Perform sign-up
            }
        }
    }
}

#Preview {
    LoginView()
}
