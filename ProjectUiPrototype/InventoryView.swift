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

    @Environment(\.dismiss) private var dismiss
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

                TextField("", text: $searchText, prompt: Text("Search Items").foregroundColor(.white.opacity(0.7)))
                    .foregroundColor(.white)
                    .accentColor(.white)
            }
            .padding(14)
            .background(Color.black.opacity(0.45))
            .clipShape(Capsule())
            .padding(.horizontal, 24)

            ScrollView(showsIndicators: false) {
                VStack(spacing: 14) {
                    ForEach(filteredItems) { item in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(item.name)
                                    .foregroundColor(.white)
                                    .font(.headline)

                                Text(item.amount)
                                    .foregroundColor(item.isLow ? .yellow : .white.opacity(0.9))
                                    .font(.subheadline.weight(.semibold))
                            }

                            Spacer()
                        }
                        .padding()
                        .background(Color.black.opacity(0.55))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 10)
            }

            Spacer(minLength: 20)
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
    }
}

#Preview {
    NavigationStack {
        InventoryView()
    }
}
