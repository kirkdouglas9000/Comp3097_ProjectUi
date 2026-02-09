//
//  ManageShiftsView.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-02-08.




import SwiftUI

struct ManagerInventoryView: View {

    struct Item: Identifiable {
        let id = UUID()
        let name: String
        let amount: String
        let low: Bool
    }

    @Environment(\.dismiss) private var dismiss
    @State private var search = ""

    private let items: [Item] = [
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
                TextField("Search Items", text: $search)
                    .foregroundColor(.white)
            }
            .padding(14)
            .background(Color.black.opacity(0.45))
            .clipShape(Capsule())
            .padding(.horizontal, 24)

            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 14) {
                    ForEach(filtered) { item in
                        HStack {
                            Text(item.name)
                                .foregroundColor(.white)
                                .font(.headline)

                            Spacer()

                            Text(item.amount)
                                .foregroundColor(item.low ? .yellow : .white)
                                .font(.subheadline.weight(.semibold))
                        }
                        .padding()
                        .background(Color.black.opacity(0.55))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 10)
            }

            
            Button(action: {}) {
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
    }
}
