//
//  PostAnnouncementsView.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-02-08.
//

import SwiftUI

struct PostAnnouncementView: View {
    @EnvironmentObject var store: StorageManager
    @Binding var isPresented: Bool

    @State private var title = ""
    @State private var message = ""
    @State private var errorMessage: String?

    var isFormValid: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            
            Image("pointseven")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(Color.black.opacity(0.45))

            
            VStack {
                Spacer()

                VStack(spacing: 16) {
                    Text("Post Announcement")
                        .font(.title3.bold())
                        .foregroundColor(.white)

                    CustomInputField(
                        text: $title,
                        placeholder: "Title"
                    )

                    ZStack(alignment: .topLeading) {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white.opacity(0.18))
                            .frame(height: 120)

                        if message.isEmpty {
                            Text("Message")
                                .foregroundColor(.white.opacity(0.65))
                                .padding(.horizontal, 14)
                                .padding(.vertical, 14)
                        }

                        TextEditor(text: $message)
                            .scrollContentBackground(.hidden)
                            .background(Color.clear)
                            .foregroundColor(.white)
                            .accentColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 8)
                            .frame(height: 120)
                    }

                    if let errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                    }

                    Button {
                        guard isFormValid else {
                            errorMessage = "Please fill all fields"
                            return
                        }

                        let userId = UserDefaults.standard.string(forKey: "currentUserId")
                        let uuid = UUID(uuidString: userId ?? "")

                        let announcement = AnnouncementModel(
                            title: title,
                            body: message,
                            postedBy: uuid
                        )

                        store.addAnnouncement(announcement)
                        isPresented = false
                    } label: {
                        Text("Publish")
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .background(isFormValid ? Color.yellow : Color.gray)
                            .foregroundColor(.black)
                            .cornerRadius(12)
                    }
                    .disabled(!isFormValid)
                }
                .padding()
                .frame(maxWidth: 340)
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .padding(.horizontal)

                Spacer()
            }

            
            Button {
                isPresented = false
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.black.opacity(0.7))
                    .clipShape(Circle())
            }
            .padding(.top, 55)
            .padding(.leading, 16)
        }
    }
}


struct CustomInputField: View {
    @Binding var text: String
    let placeholder: String

    var body: some View {
        TextField(
            "",
            text: $text,
            prompt: Text(placeholder)
                .foregroundColor(.white.opacity(0.7))
        )
        .padding(.horizontal, 12)
        .frame(height: 42)
        .background(Color.white.opacity(0.2))
        .cornerRadius(12)
        .foregroundColor(.white)
        .accentColor(.white)
    }
}
