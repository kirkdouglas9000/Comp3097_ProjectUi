//
//  ManagerInventoryView.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-02-08.
//
import SwiftUI

struct ManagerInventoryView: View {

    struct ManagerInventoryItem: Identifiable {
        let id = UUID()
        let name: String
        let amount: String
        let isLow: Bool
    }

    @State private var search = ""

    private let items: [ManagerInventoryItem] = [
        .init(name: "Coffee Beans", amount: "25 kg", isLow: false),
        .init(name: "Milk", amount: "3 left", isLow: true),
        .init(name: "Bagels", amount: "12 pcs", isLow: false)
    ]

    var filteredItems: [ManagerInventoryItem] {
        if search.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return items
        }
        return items.filter { $0.name.localizedCaseInsensitiveContains(search) }
    }

    var body: some View {
        ZStack {
            Image("pointseven")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 1.5)
                .overlay(Color.black.opacity(0.12))

            VStack(spacing: 18) {

                Text("Inventory")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .padding(.top, 40)

                // ITEMS
                VStack(spacing: 12) {
                    ForEach(filteredItems) { item in
                        ManagerInventoryRow(item: item)
                    }
                }
                .padding(.horizontal, 20)

                // ADD ITEM BUTTON
                Button {
                    // SHOW ADD ITEM FORM
                } label: {
                    Text("+ Add Item")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color.brown.opacity(0.85))
                        .clipShape(Capsule())
                }
                .padding(.horizontal, 40)

                Spacer()

                // SEARCH BAR
                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white.opacity(0.9))

                    TextField("Search Inventory", text: $search)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 18)
                .padding(.vertical, 12)
                .background(Color.brown.opacity(0.85))
                .clipShape(Capsule())
                .padding(.horizontal, 24)
                .padding(.bottom, 18)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
