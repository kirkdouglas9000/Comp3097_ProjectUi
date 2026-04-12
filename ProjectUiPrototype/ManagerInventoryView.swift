//
//  ManageShiftsView.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-02-08.
//  101401017

import SwiftUI

struct ManagerInventoryView: View {
    @EnvironmentObject var store: StorageManager

    @Binding var isPresented: Bool

    @State private var search = ""
    @State private var newName = ""
    @State private var newQuantity = ""
    @State private var showAdd = false

    var filtered: [InventoryItemModel] {
        let query = search.trimmingCharacters(in: .whitespacesAndNewlines)

        if query.isEmpty {
            return store.inventory.sorted {
                $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
            }
        }

        return store.inventory
            .filter {
                $0.name.localizedCaseInsensitiveContains(query)
            }
            .sorted {
                $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending
            }
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            Image("pointseven")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(Color.black.opacity(0.45))

            VStack {
                Spacer()

                VStack(spacing: 16) {
                    Text("Inventory")
                        .font(.title2.bold())
                        .foregroundColor(.white)

                    TextField(
                        "",
                        text: $search,
                        prompt: Text("Search")
                            .foregroundColor(.white.opacity(0.6))
                    )
                    .padding(.horizontal, 12)
                    .frame(height: 42)
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(12)
                    .foregroundColor(.white)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)

                    ScrollView {
                        VStack(spacing: 10) {
                            if filtered.isEmpty {
                                Text("No inventory items found")
                                    .foregroundColor(.white.opacity(0.85))
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 24)
                                    .background(Color.white.opacity(0.12))
                                    .cornerRadius(12)
                            } else {
                                ForEach(filtered) { item in
                                    inventoryRow(item)
                                }
                            }
                        }
                    }
                    .frame(maxHeight: 260)

                    Button {
                        showAdd.toggle()
                    } label: {
                        Text("+ Add Item")
                            .frame(maxWidth: .infinity)
                            .frame(height: 45)
                            .background(Color.yellow)
                            .foregroundColor(.black)
                            .cornerRadius(20)
                    }
                }
                .padding()
                .frame(maxWidth: 340)
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .padding(.horizontal)

                Spacer()
            }

            Button {
                isPresented = false
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
            }
            .padding(.top, 55)
            .padding(.leading, 16)
            .zIndex(999)
        }
        .sheet(isPresented: $showAdd) {
            VStack(spacing: 20) {
                Text("Add Item")
                    .font(.title2.bold())

                TextField("Item Name", text: $newName)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 250)

                TextField("Quantity", text: $newQuantity)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 250)

                Button("Save") {
                    let trimmedName = newName.trimmingCharacters(in: .whitespacesAndNewlines)
                    let quantity = Int(newQuantity) ?? 0

                    guard !trimmedName.isEmpty else { return }

                    let item = InventoryItemModel(
                        name: trimmedName,
                        quantity: max(0, quantity),
                        unit: nil,
                        lowStockThreshold: 5
                    )

                    store.addInventory(item)

                    newName = ""
                    newQuantity = ""
                    showAdd = false
                }

                Button("Cancel") {
                    showAdd = false
                }
            }
            .padding()
        }
    }

    private func inventoryRow(_ item: InventoryItemModel) -> some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .foregroundColor(.white)
                    .font(.headline)

                Text("Quantity: \(item.quantity)")
                    .foregroundColor(.white.opacity(0.85))
                    .font(.subheadline)
            }

            Spacer()

            HStack(spacing: 8) {
                Button {
                    updateQuantity(for: item, delta: -1)
                } label: {
                    Image(systemName: "minus")
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .background(Color.white.opacity(0.16))
                        .clipShape(Circle())
                }

                Text("\(item.quantity)")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(minWidth: 24)

                Button {
                    updateQuantity(for: item, delta: 1)
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .frame(width: 30, height: 30)
                        .background(Color.white.opacity(0.16))
                        .clipShape(Circle())
                }

                Button {
                    store.inventory.removeAll { $0.id == item.id }
                } label: {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .frame(width: 30, height: 30)
                        .background(Color.white.opacity(0.10))
                        .clipShape(Circle())
                }
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(Color.white.opacity(0.15))
        .cornerRadius(12)
    }

    private func updateQuantity(for item: InventoryItemModel, delta: Int) {
        guard let index = store.inventory.firstIndex(where: { $0.id == item.id }) else { return }
        let newValue = max(0, store.inventory[index].quantity + delta)
        store.inventory[index].quantity = newValue
    }
}
