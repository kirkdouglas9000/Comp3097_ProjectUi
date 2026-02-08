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
            Image("pointseven")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 1.5)
                .overlay(Color.black.opacity(0.15))

            VStack {
                Spacer()

                VStack(spacing: 16) {

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Announcements")
                            .font(.headline)
                            .foregroundColor(.white)

                        Text("Seasonal menu launch on Monday")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.85))

                        Button(action: {}) {
                            Text("View all")
                                .font(.headline)
                                .foregroundColor(.black)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                                .background(Color.white.opacity(0.95))
                                .clipShape(Capsule())
                        }
                        .buttonStyle(.plain)
                        .padding(.top, 6)
                    }
                    .padding(16)
                    .background(Color(red: 0.25, green: 0.16, blue: 0.12).opacity(0.85))
                    .cornerRadius(18)

                    VStack(spacing: 14) {
                        DashboardPill(title: "My Schedule")
                        DashboardPill(title: "Inventory")
                        DashboardPill(title: "Announcements")
                    }
                }
                .frame(maxWidth: 360)
                .padding(.horizontal, 18)

                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DashboardPill: View {
    let title: String

    var body: some View {
        Button(action: {}) {
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(
                    Color(red: 0.25, green: 0.16, blue: 0.12)
                        .opacity(0.75)
                )
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        StaffDashboardView()
    }
}
