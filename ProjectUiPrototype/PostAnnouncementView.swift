//
//  PostAnnouncementsView.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-02-08.
//

import SwiftUI

struct PostAnnouncementView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var title = ""
    @State private var message = ""

    var body: some View {
        VStack(spacing: 20) {

            
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
            .padding(.top, 12)

            
            Text("POST AN ANNOUNCEMENT")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, -8)

            
            VStack(spacing: 16) {
                TextField("Title", text: $title)
                    .padding()
                    .background(Color.white.opacity(0.15))
                    .cornerRadius(12)
                    .foregroundColor(.white)

                TextField("Message", text: $message)
                    .padding()
                    .background(Color.white.opacity(0.15))
                    .cornerRadius(12)
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 24)

            
            Button(action: {}) {
                Text("Publish")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.brown.opacity(0.7))
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 60)

            
            Button(action: { dismiss() }) {
                Text("Cancel")
                    .foregroundColor(.white.opacity(0.8))
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.brown.opacity(0.45))
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 60)

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
    }
}
