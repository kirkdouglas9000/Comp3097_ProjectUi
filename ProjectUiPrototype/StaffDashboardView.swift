//
//  StaffDashboardView.swift
//  ProjectUiPrototype
//
//  Created by Andrei Gania on 2026-02-08.
//

import SwiftUI

struct StaffDashboardView: View {
    var body: some View {
        ZStack {
            // Background image
            Image("pointseven")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 1.0)
                .overlay(Color.black.opacity(0.25))

            VStack(spacing: 18) {

                // Announcements card
                VStack(alignment: .leading, spacing: 10) {
                    Text("Announcements")
                        .font(.headline)
                        .foregroundColor(.white)

                    Text("Seasonal menu launch on Monday")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.85))

                    Button(action: {
                        // TODO: Navigate to announcements list later
                    }) {
                        Text("View all")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(Color.white.opacity(0.9))
                            .clipShape(Capsule())
                    }
                    .padding(.top, 6)
                }
                .padding(18)
                .background(Color(.sRGB, red: 0.28, green: 0.18, blue: 0.14, opacity: 0.85))
                .cornerRadius(18)
                .padding(.horizontal, 18)
                .padding(.top, 16)

                // Main buttons
                VStack(spacing: 14) {
                    DashboardButton(title: "My Schedule") {
                        // TODO
                    }

                    DashboardButton(title: "Inventory") {
                        // TODO
                    }

                    DashboardButton(title: "Announcements") {
                        // TODO
                    }
                }
                .padding(.horizontal, 18)

                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DashboardButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color(.sRGB, red: 0.30, green: 0.20, blue: 0.16, opacity: 0.85))
                .clipShape(Capsule())
        }
    }
}

#Preview {
    NavigationStack {
        StaffDashboardView()
    }
}
