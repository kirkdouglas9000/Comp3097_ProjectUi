//
//  UserDebugView.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-04-12.
//
import SwiftUI

struct UsersDebugView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var store: StorageManager

    @State private var searchText = ""
    @State private var selectedUser: User?
    @State private var showDeleteAlert = false
    @State private var userToDelete: User?

    private var filteredUsers: [User] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        let users = query.isEmpty
            ? store.users
            : store.users.filter {
                $0.name.localizedCaseInsensitiveContains(query) ||
                $0.email.localizedCaseInsensitiveContains(query) ||
                $0.username.localizedCaseInsensitiveContains(query) ||
                $0.role.localizedCaseInsensitiveContains(query)
            }

        return users.sorted {
            $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
        }
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Image("pointseven")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
                    .ignoresSafeArea()
                    .blur(radius: 1.5)
                    .overlay(Color.black.opacity(0.30))

                VStack(spacing: 14) {
                    Spacer()
                        .frame(height: geo.safeAreaInsets.top + 40)

                    Text("Registered Users")
                        .font(.title.bold())
                        .foregroundColor(.white)

                    HStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.white.opacity(0.8))

                        TextField(
                            "",
                            text: $searchText,
                            prompt: Text("Search users")
                                .foregroundColor(.white.opacity(0.6))
                        )
                        .foregroundColor(.white)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    }
                    .padding(.horizontal, 14)
                    .frame(height: 42)
                    .background(Color.black.opacity(0.42))
                    .clipShape(Capsule())
                    .padding(.horizontal, 20)

                    ScrollView {
                        VStack(spacing: 10) {
                            if filteredUsers.isEmpty {
                                emptyStateView
                            } else {
                                ForEach(filteredUsers) { user in
                                    userCard(user)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    }

                    Spacer(minLength: 0)
                }

                backButtonOverlay(geo: geo)
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .sheet(item: $selectedUser) { user in
            EditUserSheet(user: user)
                .environmentObject(store)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
        }
        .alert("Delete User", isPresented: $showDeleteAlert, presenting: userToDelete) { user in
            Button("Delete", role: .destructive) {
                store.deleteUser(user.id)
            }
            Button("Cancel", role: .cancel) { }
        } message: { user in
            Text("Are you sure you want to delete \(user.name)?")
        }
    }

    private var emptyStateView: some View {
        VStack(spacing: 8) {
            Text("No users found")
                .font(.headline)
                .foregroundColor(.white)

            Text("Try another search term.")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 28)
        .background(Color.black.opacity(0.35))
        .cornerRadius(16)
    }

    private func userCard(_ user: User) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.name)
                        .font(.headline)
                        .foregroundColor(.white)

                    Text(user.email)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.88))

                    Text("@\(user.username)")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.65))
                }

                Spacer()

                Text(user.role.capitalized)
                    .font(.caption.weight(.semibold))
                    .foregroundColor(user.role.lowercased() == "manager" ? .black : .white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(
                        user.role.lowercased() == "manager"
                        ? Color.yellow
                        : Color.white.opacity(0.16)
                    )
                    .cornerRadius(8)
            }

            if let phone = user.phone, !phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                Text(phone)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.75))
            }

            HStack(spacing: 8) {
                Button {
                    selectedUser = user
                } label: {
                    Text("Edit")
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 7)
                        .background(Color.blue.opacity(0.78))
                        .cornerRadius(8)
                }
                .buttonStyle(.plain)

                Button {
                    let newRole = user.role.lowercased() == "manager" ? "staff" : "manager"
                    store.updateUserRole(user.id, newRole: newRole)
                } label: {
                    Text(user.role.lowercased() == "manager" ? "Make Staff" : "Make Manager")
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 7)
                        .background(Color.orange.opacity(0.80))
                        .cornerRadius(8)
                }
                .buttonStyle(.plain)

                Spacer()

                Button {
                    userToDelete = user
                    showDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.white)
                        .frame(width: 34, height: 34)
                        .background(Color.red.opacity(0.78))
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
                .disabled(user.username.lowercased() == "admin")
                .opacity(user.username.lowercased() == "admin" ? 0.45 : 1.0)
            }
        }
        .padding(14)
        .background(Color.black.opacity(0.42))
        .cornerRadius(16)
    }

    private func backButtonOverlay(geo: GeometryProxy) -> some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 44, height: 44)
                        .background(Color.black.opacity(0.45))
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
}
