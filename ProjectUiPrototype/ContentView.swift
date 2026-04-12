//
//  ContentView.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-02-07.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var store: StorageManager

    @State private var username = ""
    @State private var password = ""
    @State private var goDashboard = false
    @State private var goManagerDashboard = false
    @State private var loginError: String?

    var body: some View {
        ZStack {
            
            Image("pointseven")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 3)
                .overlay(Color.black.opacity(0.35))

            VStack(spacing: 18) {

                
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.black.opacity(0.4))
                            .clipShape(Circle())
                    }
                    Spacer()
                }
                .padding(.horizontal)

                Spacer()

                
                Text("Sign in to your account")
                    .font(.headline)
                    .foregroundColor(.white)

                
                VStack(spacing: 10) {

                    TextField(
                        "",
                        text: $username,
                        prompt: Text("Username")
                            .foregroundColor(.white.opacity(0.55))
                    )
                    .padding(.horizontal, 12)
                    .frame(width: 260, height: 42)
                    .background(Color.black.opacity(0.4))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .accentColor(.white)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)

                    SecureField(
                        "",
                        text: $password,
                        prompt: Text("Password")
                            .foregroundColor(.white.opacity(0.55))
                    )
                    .padding(.horizontal, 12)
                    .frame(width: 260, height: 42)
                    .background(Color.black.opacity(0.4))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .accentColor(.white)
                }

                if let err = loginError {
                    Text(err)
                        .foregroundColor(.red)
                        .font(.footnote)
                }

                
                Button {
                    loginError = nil

                    if let user = store.authenticate(username: username, password: password) {
                        UserDefaults.standard.set(user.id.uuidString, forKey: "currentUserId")

                        if user.role.lowercased() == "manager" {
                            goManagerDashboard = true
                        } else {
                            goDashboard = true
                        }
                    } else {
                        loginError = "Invalid username or password"
                    }
                } label: {
                    Text("Sign In")
                        .frame(width: 260, height: 42)
                        .background(Color.yellow)
                        .foregroundColor(.black)
                        .cornerRadius(20)
                }

                
                Button {
                    loginError = nil

                    if let user = store.authenticate(username: username, password: password),
                       user.role.lowercased() == "manager" {

                        UserDefaults.standard.set(user.id.uuidString, forKey: "currentUserId")
                        goManagerDashboard = true
                    } else {
                        loginError = "Manager credentials required"
                    }
                } label: {
                    Text("Sign in as Manager")
                        .frame(width: 260, height: 42)
                        .background(Color.gray.opacity(0.8))
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }

                NavigationLink(destination: RegisterView()) {
                    Text("Register")
                        .foregroundColor(.white)
                        .underline()
                }

                Spacer()

                NavigationLink("", destination: StaffDashboardView(), isActive: $goDashboard)
                NavigationLink("", destination: ManagerDashboardView(), isActive: $goManagerDashboard)
            }
            .padding(.vertical)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}
