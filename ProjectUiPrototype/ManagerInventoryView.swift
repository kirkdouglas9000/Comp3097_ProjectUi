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
        if search.isEmpty { return items }
        return items.filter { $0.name.localizedCaseInsensitiveContains(search) }
    }

    var body: some View {
        ZStack {
            Image("pointseven")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 1.5)

            VStack(spacing: 18) {

                Text("Inventory")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .padding(.top, 40)

                VStack(spacing: 12) {
                    ForEach(filteredItems) { item in
                        ManagerInventoryRow(item: item)
                    }
                }
                .padding(.horizontal, 20)

                Spacer()
            }
        }
    }
}

struct ManagerInventoryRow: View {
    let item: ManagerInventoryView.ManagerInventoryItem

    var body: some View {
        HStack {
            Text(item.name)
                .font(.headline)
                .foregroundColor(.white)

            Spacer()

            Text(item.amount)
                .font(.subheadline.weight(.semibold))
                .foregroundColor(item.isLow ? .yellow : .white)
        }
        .padding(16)
        .background(Color.black.opacity(0.5))
        .cornerRadius(12)
        .padding(.horizontal, 10)
    }
}
