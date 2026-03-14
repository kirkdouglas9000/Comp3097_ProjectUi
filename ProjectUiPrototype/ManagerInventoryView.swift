//
//  ManageShiftsView.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-02-08.


import SwiftUI

struct ManagerInventoryView: View {

    struct Item: Identifiable {
        let id = UUID()
        var name: String
        var amount: String
        var low: Bool
    }

    @Environment(\.dismiss) private var dismiss
    @State private var search = ""
    @State private var showAddItemSheet = false

    @State private var items: [Item] = [
        .init(name: "Coffee Beans", amount: "25 kg", low: false),
        .init(name: "Milk", amount: "3 left", low: true),
        .init(name: "Bagels", amount: "12 pcs", low: false)
    ]

    var filtered: [Item] {
        if search.isEmpty { return items }
        return items.filter { $0.name.localizedCaseInsensitiveContains(search) }
    }

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .padding(10)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 12)

            Text("Inventory")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(.white)
                .padding(.top, -6)

            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white.opacity(0.8))

                TextField("", text: $search, prompt: Text("Search Items").foregroundColor(.white.opacity(0.7)))
                    .foregroundColor(.white)
                    .accentColor(.white)
            }
            .padding(14)
            .background(Color.black.opacity(0.45))
            .clipShape(Capsule())
            .padding(.horizontal, 24)

            ScrollView(showsIndicators: false) {
                VStack(spacing: 14) {
                    ForEach(filtered) { item in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.name)
                                    .foregroundColor(.white)
                                    .font(.headline)

                                Text(item.amount)
                                    .foregroundColor(item.low ? .yellow : .white.opacity(0.9))
                                    .font(.subheadline.weight(.semibold))
                            }

                            Spacer()

                            Button(action: {
                                deleteItem(item)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                                    .padding(8)
                                    .background(Color.white.opacity(0.12))
                                    .clipShape(Circle())
                            }
                        }
                        .padding()
                        .background(Color.black.opacity(0.55))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 10)
            }

            Button(action: {
                showAddItemSheet = true
            }) {
                Text("+ Add Item")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color(red: 0.45, green: 0.28, blue: 0.14))
                    .clipShape(Capsule())
            }
            .padding(.horizontal, 60)
            .padding(.bottom, 20)
        }
        .background(
            Image("pointseven")
                .resizable()
                .scaledToFill()
                .blur(radius: 2)
                .overlay(Color.black.opacity(0.15))
                .ignoresSafeArea()
        )
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .sheet(isPresented: $showAddItemSheet) {
            AddInventoryItemView { name, amount in
                let lowStock = amount.lowercased().contains("left") || amount.lowercased().contains("low")
                let newItem = Item(name: name, amount: amount, low: lowStock)
                items.append(newItem)
            }
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        }
    }

    func deleteItem(_ item: Item) {
        items.removeAll { $0.id == item.id }
    }
}

struct AddInventoryItemView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var itemName = ""
    @State private var itemAmount = ""

    var onSave: (String, String) -> Void

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.10, green: 0.10, blue: 0.12)
                    .ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("Add New Item")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)

                    TextField("", text: $itemName, prompt: Text("Item name").foregroundColor(.white.opacity(0.6)))
                        .padding()
                        .background(Color.white.opacity(0.08))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.15), lineWidth: 1)
                        )

                    TextField("", text: $itemAmount, prompt: Text("Amount").foregroundColor(.white.opacity(0.6)))
                        .padding()
                        .background(Color.white.opacity(0.08))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.white.opacity(0.15), lineWidth: 1)
                        )

                    Button(action: saveItem) {
                        Text("Save Item")
                            .foregroundColor(.white)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color(red: 0.45, green: 0.28, blue: 0.14))
                            .clipShape(Capsule())
                    }

                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.white.opacity(0.8))
                }
                .padding(24)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    func saveItem() {
        let cleanName = itemName.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanAmount = itemAmount.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !cleanName.isEmpty, !cleanAmount.isEmpty else { return }

        onSave(cleanName, cleanAmount)
        dismiss()
    }
}
