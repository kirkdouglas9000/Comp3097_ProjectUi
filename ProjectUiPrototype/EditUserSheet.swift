//
//  EditUserSheet.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-04-12.
//

import SwiftUI

struct EditUserSheet: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var store: StorageManager

    let user: User

    @State private var name: String
    @State private var email: String
    @State private var username: String
    @State private var phone: String
    @State private var role: String

    init(user: User) {
        self.user = user
        _name = State(initialValue: user.name)
        _email = State(initialValue: user.email)
        _username = State(initialValue: user.username)
        _phone = State(initialValue: user.phone ?? "")
        _role = State(initialValue: user.role)
    }

    var body: some View {
        ZStack(alignment: .top) {
            Image("pointseven")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 2)
                .overlay(Color.black.opacity(0.55))

            VStack(spacing: 0) {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .font(.caption.weight(.semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 7)
                            .background(Color.black.opacity(0.45))
                            .overlay(
                                Capsule()
                                    .stroke(Color.white.opacity(0.18), lineWidth: 1)
                            )
                            .clipShape(Capsule())
                    }

                    Spacer()
                }
                .padding(.horizontal, 18)
                .padding(.top, 12)

                Spacer()
                    .frame(height: 22)

                VStack(spacing: 10) {
                    Text("Edit User")
                        .font(.title.bold())
                        .foregroundColor(.white)
                        .padding(.bottom, 4)

                    compactField("Name", text: $name)
                    compactField("Email", text: $email, keyboard: .emailAddress)
                    compactField("Username", text: $username)
                    compactField("Phone", text: $phone, keyboard: .phonePad)

                    Picker("Role", selection: $role) {
                        Text("Staff").tag("staff")
                        Text("Manager").tag("manager")
                    }
                    .pickerStyle(.segmented)
                    .colorScheme(.light)
                    .scaleEffect(0.90)

                    Button {
                        let trimmedPhone = phone.trimmingCharacters(in: .whitespacesAndNewlines)

                        let updatedUser = User(
                            id: user.id,
                            name: name.trimmingCharacters(in: .whitespacesAndNewlines),
                            email: email.trimmingCharacters(in: .whitespacesAndNewlines),
                            username: username.trimmingCharacters(in: .whitespacesAndNewlines),
                            role: role,
                            phone: trimmedPhone.isEmpty ? nil : trimmedPhone
                        )

                        store.updateUser(updatedUser)
                        dismiss()
                    } label: {
                        Text("Save Changes")
                            .font(.subheadline.weight(.bold))
                            .foregroundColor(.black)
                            .frame(width: 220, height: 36)
                            .background(Color.yellow)
                            .clipShape(Capsule())
                    }
                    .padding(.top, 4)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
                .frame(maxWidth: 340)
                .background(Color.white.opacity(0.22))
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.white.opacity(0.10), lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .padding(.horizontal, 20)

                Spacer()
            }
        }
    }

    private func compactField(
        _ placeholder: String,
        text: Binding<String>,
        keyboard: UIKeyboardType = .default
    ) -> some View {
        TextField(
            placeholder,
            text: text,
            prompt: Text(placeholder).foregroundColor(.white.opacity(0.60))
        )
        .padding(.horizontal, 12)
        .frame(width: 280, height: 30)
        .background(Color.white.opacity(0.20))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .foregroundColor(.white)
        .keyboardType(keyboard)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled()
    }
}
