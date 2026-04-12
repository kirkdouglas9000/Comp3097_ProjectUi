//
//  StorageManager.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-04-12.
//  101401017

import Foundation
import Combine

final class StorageManager: ObservableObject {

    static let shared = StorageManager()

    @Published var users: [User] = []
    @Published var shifts: [ShiftModel] = []
    @Published var inventory: [InventoryItemModel] = []
    @Published var announcements: [AnnouncementModel] = []

    private var autosaveCancellable: AnyCancellable?

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let service = "PointSeven"

    private init() {
        encoder.dateEncodingStrategy = .iso8601
        decoder.dateDecodingStrategy = .iso8601

        loadAll()
        createDefaultAdminIfNeeded()

        autosaveCancellable = Publishers.CombineLatest4(
            $users,
            $shifts,
            $inventory,
            $announcements
        )
        .debounce(for: .milliseconds(500), scheduler: DispatchQueue.global(qos: .background))
        .sink { [weak self] _, _, _, _ in
            self?.saveAll()
        }
    }

    // DEFAULT ADMIN
    private func createDefaultAdminIfNeeded() {
        let adminUsername = "admin"

        let exists = users.contains {
            $0.username.lowercased() == adminUsername
        }

        if !exists {
            let admin = User(
                name: "Admin",
                email: "admin@local.com",
                username: "admin",
                role: "manager",
                phone: nil
            )

            try? addUser(admin, password: "admin123")
        }
    }

    private func url(_ name: String) -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(name)
    }

    private func loadAll() {
        users = load([User].self, file: "users.json")
        shifts = load([ShiftModel].self, file: "shifts.json")
        inventory = load([InventoryItemModel].self, file: "inventory.json")
        announcements = load([AnnouncementModel].self, file: "announcements.json")
    }

    private func saveAll() {
        save(users, file: "users.json")
        save(shifts, file: "shifts.json")
        save(inventory, file: "inventory.json")
        save(announcements, file: "announcements.json")
    }

    private func load<T: Decodable>(_ type: T.Type, file: String) -> T where T: ExpressibleByArrayLiteral {
        do {
            let data = try Data(contentsOf: url(file))
            return try decoder.decode(T.self, from: data)
        } catch {
            return []
        }
    }

    private func save<T: Encodable>(_ value: T, file: String) {
        do {
            let data = try encoder.encode(value)
            try data.write(to: url(file), options: .atomic)
        } catch {
            print("Save error:", error)
        }
    }

    // ADD USER
    func addUser(_ user: User, password: String) throws {
        guard !users.contains(where: {
            $0.username.lowercased() == user.username.lowercased()
        }) else {
            throw NSError(
                domain: "Storage",
                code: 1,
                userInfo: [NSLocalizedDescriptionKey: "Username already exists"]
            )
        }

        users.append(user)

        let hash = hashPassword(password)
        KeychainHelper.shared.save(
            Data(hash.utf8),
            service: service,
            account: user.id.uuidString
        )
    }

    // AUTHENTICATE USING USERNAME
    func authenticate(username: String, password: String) -> User? {
        guard let user = users.first(where: {
            $0.username.lowercased() == username.lowercased()
        }) else { return nil }

        guard let data = KeychainHelper.shared.read(
            service: service,
            account: user.id.uuidString
        ),
        let stored = String(data: data, encoding: .utf8) else { return nil }

        return stored == hashPassword(password) ? user : nil
    }

    // UPDATE FULL USER
    func updateUser(_ updatedUser: User) {
        guard let index = users.firstIndex(where: { $0.id == updatedUser.id }) else { return }

        if users[index].username.lowercased() != updatedUser.username.lowercased() {
            let usernameTaken = users.contains {
                $0.id != updatedUser.id &&
                $0.username.lowercased() == updatedUser.username.lowercased()
            }

            if usernameTaken { return }
        }

        users[index] = updatedUser
    }

    // UPDATE ONLY ROLE
    func updateUserRole(_ userId: UUID, newRole: String) {
        guard let index = users.firstIndex(where: { $0.id == userId }) else { return }
        users[index].role = newRole
    }

    func deleteUser(_ id: UUID) {
        users.removeAll { $0.id == id }

        KeychainHelper.shared.delete(
            service: service,
            account: id.uuidString
        )

        shifts.removeAll { $0.userId == id || $0.createdBy == id }
        announcements.removeAll { $0.postedBy == id }
    }

    func addShift(_ s: ShiftModel) {
        shifts.append(s)
    }

    func addInventory(_ i: InventoryItemModel) {
        inventory.append(i)
    }

    func addAnnouncement(_ a: AnnouncementModel) {
        announcements.append(a)
    }
}
