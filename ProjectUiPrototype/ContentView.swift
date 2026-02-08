//
//  ContentView.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-02-07.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var goDashboard = false
    @State private var goManagerDashboard = false

    var body: some View {
        ZStack {
            // Background image
            Image("pointseven")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 1.0)
                .overlay(Color.black.opacity(0.15))

            VStack(spacing: 20) {

                Text("Sign in to your account")
                    .font(.title3)
                    .foregroundColor(.white)
                    .bold()

                // Textfields
                VStack(spacing: 15) {
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color.white.opacity(0.15))
                        .foregroundColor(.white)
                        .cornerRadius(10)

                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white.opacity(0.15))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                // Sign In Button
                Button(action: {
                    goDashboard = true
                }) {
                    Text("Sign In")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(25)
                }

                
                Button(action: {
                    goManagerDashboard = true
                }) {
                    Text("Sign in as Manager")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.darkGray))
                        .cornerRadius(25)
                }

                
                Button(action: {}) {
                    Text("Forgot my password?")
                        .foregroundColor(.white.opacity(0.7))
                        .font(.footnote)
                }

                // Register button
                Button(action: {}) {
                    Text("Register")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                }
            }
            
            .frame(maxWidth: 350)
            .padding()
            .background(Color.black.opacity(0.35))
            .cornerRadius(20)
            .padding()
        }
        .navigationDestination(isPresented: $goDashboard){
            StaffDashboardView()
        }
        .navigationDestination(isPresented: $goManagerDashboard){
            ManagerDashboardView()
        }
    }
}

#Preview {
    LoginView()
}
