//
//  R.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-02-07.
//


import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var store: StorageManager
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage: String?

    var body: some View {
        ZStack {
            Image("pointseven")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(Color.black.opacity(0.45))

            VStack(spacing: 20) {

                Text("Register your account")
                    .font(.headline)
                    .foregroundColor(.white)

                VStack(spacing: 12) {
                    CustomField(text: $name, placeholder: "Name")
                    CustomField(text: $email, placeholder: "Email")
                    CustomField(text: $username, placeholder: "Username")
                    CustomSecureField(text: $password, placeholder: "Password")
                    CustomSecureField(text: $confirmPassword, placeholder: "Confirm Password")
                }

                if let errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.footnote)
                }

                Button {

                    guard !name.isEmpty,
                          !username.isEmpty,
                          !password.isEmpty else {
                        errorMessage = "Fill all fields"
                        return
                    }

                    guard password == confirmPassword else {
                        errorMessage = "Passwords do not match"
                        return
                    }

                    let newUser = User(
                        name: name,
                        email: email,
                        username: username,
                        role: "staff",
                        phone: nil
                    )

                    do {
                        try store.addUser(newUser, password: password)
                        dismiss()
                    } catch {
                        errorMessage = error.localizedDescription
                    }

                } label: {
                    Text("Register")
                        .frame(width: 260, height: 42)
                        .background(Color.yellow)
                        .foregroundColor(.black)
                        .cornerRadius(20)
                }

                Spacer()
            }
            .frame(maxWidth: 320)
            .padding()
            .background(Color.black.opacity(0.4))
            .cornerRadius(20)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct CustomField: View {
    @Binding var text: String
    let placeholder: String

    var body: some View {
        TextField(
            "",
            text: $text,
            prompt: Text(placeholder)
                .foregroundColor(.white.opacity(0.7))
        )
        .padding(.horizontal, 10)
        .frame(height: 42)
        .background(Color.white.opacity(0.3))
        .cornerRadius(10)
        .foregroundColor(.white)
    }
}

struct CustomSecureField: View {
    @Binding var text: String
    let placeholder: String

    var body: some View {
        SecureField(
            "",
            text: $text,
            prompt: Text(placeholder)
                .foregroundColor(.white.opacity(0.7))
        )
        .padding(.horizontal, 10)
        .frame(height: 42)
        .background(Color.white.opacity(0.3))
        .cornerRadius(10)
        .foregroundColor(.white)
    }
}
