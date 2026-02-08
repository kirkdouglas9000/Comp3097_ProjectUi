//
//  R.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-02-07.
//

import SwiftUI

struct RegisterView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    var body: some View {
        ZStack {
            // Background image
            Image("pointseven")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(Color.black.opacity(0.45))

            VStack(spacing: 25) {

                Text("Register your account")
                    .font(.headline)
                    .foregroundColor(.white)
                    .bold()

                VStack(spacing: 18) {
                    CustomField(text: $name, placeholder: "Name")
                    CustomField(text: $email, placeholder: "Email Address")
                    CustomField(text: $username, placeholder: "Username")
                    CustomSecureField(text: $password, placeholder: "Password")
                    CustomSecureField(text: $confirmPassword, placeholder: "Repeat Password")
                }

                // Register button
                Button(action: {
                    
                }) {
                    Text("Register")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(25)
                }
                .padding(.top, 15)

                Spacer(minLength: 20)
            }
            .frame(maxWidth: 350)
            .padding(.vertical, 40)
            .padding(.horizontal, 20)
            .background(Color.black.opacity(0.40))
            .cornerRadius(25)
            .padding()
        }
    }
}

#Preview {
    RegisterView()
}


struct CustomField: View {
    @Binding var text: String
    let placeholder: String

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.horizontal, 16)
            }

            TextField("", text: $text)
                .foregroundColor(.white)
                .padding()
        }
        .background(Color.white.opacity(0.15))
        .cornerRadius(10)
    }
}


struct CustomSecureField: View {
    @Binding var text: String
    let placeholder: String

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.horizontal, 16)
            }

            SecureField("", text: $text)
                .foregroundColor(.white)
                .padding()
        }
        .background(Color.white.opacity(0.15))
        .cornerRadius(10)
    }
}

