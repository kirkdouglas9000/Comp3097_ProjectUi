//
//  InventoryView.swift
//  ProjectUiPrototype
//
//  Created by Andrei Gania on 2026-02-08.
//

import SwiftUI

struct InventoryView: View {

    struct InventoryItem: Identifiable {
        let id = UUID()
        let name: String
        let amount: String
        let isLow: Bool
    }

    @State private var searchText = ""

    private let items: [InventoryItem] = [
        .init(name: "Coffee Beans", amount: "25 kg", isLow: false),
        .init(name: "Milk", amount: "3 left", isLow: true),
        .init(name: "Bagels", amount: "12 pcs", isLow: false)
    ]

    var filteredItems: [InventoryItem] {
        if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return items
        }
        return items.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    var body: some View {
        ZStack {
            Image("pointseven")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 1.5)
                .overlay(Color.black.opacity(0.15))

            VStack(spacing: 18) {

                Text("Inventory")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .padding(.top, 10)

                VStack(spacing: 12) {
                    ForEach(filteredItems) { item in
                        InventoryRow(item: item)
                    }
                }
                .padding(.horizontal, 18)
                .padding(.top, 6)

                Button(action: {
                }) {
                    Text("+ Add Item")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color(red: 0.45, green: 0.29, blue: 0.16).opacity(0.85))
                        .clipShape(Capsule())
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 60)
                .padding(.top, 6)

                Spacer()

                HStack(spacing: 10) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.white.opacity(0.9))

                    TextField("Search Inventory", text: $searchText)
                        .foregroundColor(.white)
                        .submitLabel(.search)
                }
                .padding(.horizontal, 18)
                .padding(.vertical, 12)
                .background(Color(red: 0.45, green: 0.29, blue: 0.16).opacity(0.85))
                .clipShape(Capsule())
                .padding(.horizontal, 24)
                .padding(.bottom, 18)
            }
        }
        
        
    }
}

struct InventoryRow: View {
    let item: InventoryView.InventoryItem

    var body: some View {
        HStack {
            Text(item.name)
                .font(.headline)
                .foregroundColor(.white)

            Spacer()

            Text(item.amount)
                .font(.subheadline.weight(.semibold))
                .foregroundColor(item.isLow ? Color.yellow : Color.white.opacity(0.9))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            item.isLow
            ? Color(red: 0.46, green: 0.23, blue: 0.13).opacity(0.90)
            : Color(red: 0.20, green: 0.13, blue: 0.10).opacity(0.85)
        )
        .cornerRadius(12)
    }
}

#Preview {
    NavigationStack {
        InventoryView()
    }
}
