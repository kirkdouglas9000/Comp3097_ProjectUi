//
//  ContentView.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-02-07.
//
import SwiftUI

struct LoginView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var username = ""
    @State private var password = ""
    @State private var goDashboard = false
    @State private var goManagerDashboard = false

    var body: some View {
        VStack(spacing: 20) {

            // BACK BUTTON
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(10)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 10)

            Text("Sign in to your account")
                .font(.title3.bold())
                .foregroundColor(.white)

            // INPUTS
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
            .padding(.horizontal, 20)

            // SIGN IN
            Button(action: { goDashboard = true }) {
                Text("Sign In")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.yellow)
                    .cornerRadius(25)
            }
            .padding(.horizontal, 40)

            // MANAGER LOGIN
            Button(action: { goManagerDashboard = true }) {
                Text("Sign in as Manager")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(.darkGray))
                    .cornerRadius(25)
            }
            .padding(.horizontal, 40)

            Button("Forgot my password?") {
            }
            .foregroundColor(.white.opacity(0.7))
            .font(.footnote)

            Button(action: {}) {
                Text("Register")
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(25)
            }
            .padding(.horizontal, 40)

            Spacer()
        }
        .background(
            Image("pointseven")
                .resizable()
                .scaledToFill()
                .blur(radius: 2)
                .overlay(Color.black.opacity(0.15))
                .ignoresSafeArea()
        )
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .navigationDestination(isPresented: $goDashboard) { StaffDashboardView() }
        .navigationDestination(isPresented: $goManagerDashboard) { ManagerDashboardView() }
    }
}
