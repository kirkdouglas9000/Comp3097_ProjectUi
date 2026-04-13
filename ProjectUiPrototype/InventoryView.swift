//
//  InventoryView.swift
//  ProjectUiPrototype
//
//  Created by Denrick Viera on 2026-02-08.
//  101426295

import SwiftUI

struct InventoryView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var store: StorageManager

    @State private var searchText = ""

    private var filteredItems: [InventoryItemModel] {
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        let items = query.isEmpty
            ? store.inventory
            : store.inventory.filter {
                $0.name.localizedCaseInsensitiveContains(query)
            }

        return items.sorted { first, second in
            let firstLow = isLowStock(first)
            let secondLow = isLowStock(second)

            if firstLow != secondLow {
                return firstLow && !secondLow
            }

            return first.name.localizedCaseInsensitiveCompare(second.name) == .orderedAscending
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
                    .overlay(Color.black.opacity(0.28))

                VStack(spacing: 12) {
                    Spacer()
                        .frame(height: geo.safeAreaInsets.top + 40)

                    headerView
                    searchBar
                    inventoryList

                    Spacer(minLength: 10)
                }
                .padding(.horizontal, 16)

                backButtonOverlay(geo: geo)
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }

    private var headerView: some View {
        VStack(spacing: 4) {
            Text("Inventory")
                .font(.title.bold())
                .foregroundColor(.white)

            Text("Check stock levels and update item counts.")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))
        }
    }

    private var searchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white.opacity(0.8))

            TextField(
                "",
                text: $searchText,
                prompt: Text("Search Inventory")
                    .foregroundColor(.white.opacity(0.6))
            )
            .foregroundColor(.white)
            .autocapitalization(.none)
            .disableAutocorrection(true)
        }
        .padding(.horizontal, 14)
        .frame(height: 42)
        .background(Color.black.opacity(0.45))
        .clipShape(Capsule())
    }

    private var inventoryList: some View {
        ScrollView {
            VStack(spacing: 8) {
                if filteredItems.isEmpty {
                    emptyStateView
                } else {
                    ForEach(filteredItems) { item in
                        inventoryRow(item)
                    }
                }
            }
            .padding(.top, 2)
            .padding(.bottom, 8)
        }
    }

    private var emptyStateView: some View {
        VStack(spacing: 8) {
            Text("No inventory items found")
                .font(.headline)
                .foregroundColor(.white)

            Text("Try another search term.")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 28)
        .background(Color.black.opacity(0.35))
        .cornerRadius(14)
    }

    private func inventoryRow(_ item: InventoryItemModel) -> some View {
        let unitText = item.unit ?? ""
        let lowStock = isLowStock(item)

        return VStack(spacing: 8) {
            HStack(alignment: .center, spacing: 10) {
                VStack(alignment: .leading, spacing: 3) {
                    HStack(spacing: 6) {
                        Text(item.name)
                            .font(.subheadline.weight(.semibold))
                            .foregroundColor(.white)
                            .lineLimit(1)

                        if lowStock {
                            Text("LOW")
                                .font(.caption2.bold())
                                .foregroundColor(.black)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 3)
                                .background(Color.yellow)
                                .cornerRadius(6)
                        }
                    }

                    Text(quantityText(quantity: item.quantity, unit: unitText))
                        .font(.caption)
                        .foregroundColor(lowStock ? .yellow : .white.opacity(0.8))
                }

                Spacer()

                HStack(spacing: 8) {
                    Button {
                        updateQuantity(for: item, delta: -1)
                    } label: {
                        Image(systemName: "minus")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 28, height: 28)
                            .background(Color.white.opacity(0.14))
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)

                    Text("\(item.quantity)")
                        .font(.subheadline.weight(.bold))
                        .foregroundColor(.white)
                        .frame(minWidth: 28)

                    Button {
                        updateQuantity(for: item, delta: 1)
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 28, height: 28)
                            .background(Color.white.opacity(0.14))
                            .clipShape(Circle())
                    }
                    .buttonStyle(.plain)
                }
            }

            if let threshold = item.lowStockThreshold {
                HStack {
                    Spacer()

                    Text("Low stock at \(threshold)")
                        .font(.caption2)
                        .foregroundColor(.white.opacity(0.65))
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(Color.black.opacity(0.42))
        .cornerRadius(12)
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

    private func quantityText(quantity: Int, unit: String) -> String {
        if unit.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return "Quantity: \(quantity)"
        } else {
            return "Quantity: \(quantity) \(unit)"
        }
    }

    private func isLowStock(_ item: InventoryItemModel) -> Bool {
        guard let threshold = item.lowStockThreshold else { return false }
        return item.quantity <= threshold
    }

    private func updateQuantity(for item: InventoryItemModel, delta: Int) {
        guard let index = store.inventory.firstIndex(where: { $0.id == item.id }) else { return }

        let newValue = max(0, store.inventory[index].quantity + delta)
        store.inventory[index].quantity = newValue
    }
}
