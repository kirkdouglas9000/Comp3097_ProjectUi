//
//  ManagerDashboardView.swift
//  ProjectUiPrototype
//
//  Created by Andrei Gania on 2026-02-08.
//

import SwiftUI

struct ManagerDashboardView: View {
    
        @State private var goToShifts = false
        @State private var goToAnnouncements = false
        @State private var goToInventory = false
        @State private var goToReports = false
    
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

                VStack(spacing: 14) {

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Track")
                            .font(.headline)
                            .foregroundColor(.white)

                        HStack {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Sales")
                                Text("Orders")
                                Text("Out of stock")
                            }
                            .foregroundColor(.white.opacity(0.85))
                            .font(.subheadline)

                            Spacer()

                            VStack(alignment: .trailing, spacing: 8) {
                                Text("3,420")
                                    .fontWeight(.semibold)
                                Text("184")
                                    .fontWeight(.semibold)
                                Text("3")
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.white)
                            .font(.subheadline)
                        }
                    }
                    .padding(16)
                    .background(Color(red: 0.25, green: 0.16, blue: 0.12).opacity(0.85))
                    .cornerRadius(18)

                    ManagerPill(title: "Manage Shifts", bg: Color.yellow, fg: .black) {
                                        goToShifts = true
                                    }

                                    ManagerPill(title: "Post Announcement", bg: Color.white.opacity(0.92), fg: .black) {
                                        goToAnnouncements = true
                                    }

                                    ManagerPill(title: "Inventory", bg: Color(red: 0.25, green: 0.16, blue: 0.12).opacity(0.75), fg: .white) {
                                        goToInventory = true
                                    }

                                    ManagerPill(title: "Reports", bg: Color(red: 0.25, green: 0.16, blue: 0.12).opacity(0.75), fg: .white) {
                                        goToReports = true
                                    }
                                }
                .frame(maxWidth: 360)
                .padding(.horizontal, 18)

                Spacer()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        
        navigationDestination(isPresented: $goToShifts) {
                    ManageShiftsView() // add your real view here
                }
                .navigationDestination(isPresented: $goToAnnouncements) {
                    PostAnnouncementView() // add your real view here
                }
                .navigationDestination(isPresented: $goToInventory) {
                    ManagerInventoryView()
                }
                .navigationDestination(isPresented: $goToReports) {
                    ReportsView() // add your real view here
                }    }
}

struct ManagerPill: View {
    let title: String
    let bg: Color
    let fg: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .foregroundColor(fg)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(bg)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationStack {
        ManagerDashboardView()
    }
}
