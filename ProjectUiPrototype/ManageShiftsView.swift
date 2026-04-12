//
//  ManageShiftsView.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-02-08.
//

import SwiftUI

struct ManageShiftsView: View {
    @EnvironmentObject var store: StorageManager
    @Binding var isPresented: Bool

    @State private var selectedUser: User?
    @State private var startDate = Date()
    @State private var endDate = Date().addingTimeInterval(3600 * 8)
    @State private var position = ""
    @State private var showSuccess = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                Image("pointseven")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
                    .ignoresSafeArea()
                    .overlay(Color.black.opacity(0.45))

                
                VStack {
                    Spacer()

                    VStack(spacing: 10) {
                        Text("Manage Shifts")
                            .font(.title2.bold())
                            .foregroundColor(.white)
                            .padding(.bottom, 4)

                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Select Employee")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.8))

                            Picker("Select Employee", selection: $selectedUser) {
                                Text("Choose Employee").tag(nil as User?)
                                ForEach(store.users) { user in
                                    Text(user.name).tag(Optional(user))
                                }
                            }
                            .pickerStyle(.menu)
                            .tint(.white)
                            .frame(maxWidth: .infinity, minHeight: 42)
                            .padding(.horizontal, 10)
                            .background(Color.white.opacity(0.18))
                            .cornerRadius(12)
                        }

                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Start Time")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.8))

                            DatePicker(
                                "",
                                selection: $startDate,
                                displayedComponents: [.date, .hourAndMinute]
                            )
                            .labelsHidden()
                            .datePickerStyle(.compact)
                            .tint(.white)
                            .frame(maxWidth: .infinity, minHeight: 42, alignment: .leading)
                            .padding(.horizontal, 10)
                            .background(Color.white.opacity(0.18))
                            .cornerRadius(12)
                            .colorScheme(.dark)
                        }

                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("End Time")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.8))

                            DatePicker(
                                "",
                                selection: $endDate,
                                displayedComponents: [.date, .hourAndMinute]
                            )
                            .labelsHidden()
                            .datePickerStyle(.compact)
                            .tint(.white)
                            .frame(maxWidth: .infinity, minHeight: 42, alignment: .leading)
                            .padding(.horizontal, 10)
                            .background(Color.white.opacity(0.18))
                            .cornerRadius(12)
                            .colorScheme(.dark)
                        }

                        // POSITION
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Position")
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.8))

                            TextField(
                                "",
                                text: $position,
                                prompt: Text("Barista / Cashier")
                                    .foregroundColor(.white.opacity(0.6))
                            )
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .frame(height: 42)
                            .background(Color.white.opacity(0.18))
                            .cornerRadius(12)
                        }

                        
                        Button {
                            guard let user = selectedUser else { return }

                            let currentUserId = UserDefaults.standard.string(forKey: "currentUserId")
                            guard let managerId = UUID(uuidString: currentUserId ?? "") else { return }

                            let shift = ShiftModel(
                                userId: user.id,
                                start: startDate,
                                end: endDate,
                                position: position,
                                location: "Cafe",
                                createdBy: managerId
                            )

                            store.addShift(shift)
                            position = ""
                            showSuccess = true
                        } label: {
                            Text("Add Shift")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 46)
                                .background(Color.orange)
                                .cornerRadius(16)
                        }
                        .padding(.top, 6)

                        if showSuccess {
                            Text("Shift added successfully ✅")
                                .font(.caption)
                                .foregroundColor(.green)
                                .padding(.top, 2)
                        }
                    }
                    .padding(18)
                    .frame(maxWidth: 340)
                    .background(.ultraThinMaterial)
                    .cornerRadius(24)
                    .padding(.horizontal, 20)

                    Spacer()
                }
                .padding(.top, 70)

                
                VStack {
                    HStack {
                        Button {
                            isPresented = false
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: 42, height: 42)
                                .background(Color.black.opacity(0.65))
                                .clipShape(Circle())
                        }

                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, geo.safeAreaInsets.top + 8)

                    Spacer()
                }
                .zIndex(10)
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
    }
}
