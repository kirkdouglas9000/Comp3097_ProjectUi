//
//  MyScheduleView.swift
//  ProjectUiPrototype
//
//  Created by Andrei Gania on 2026-02-08.
//  101478350

import SwiftUI

struct MyScheduleView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var store: StorageManager

    private var currentUserId: UUID? {
        guard let idString = UserDefaults.standard.string(forKey: "currentUserId") else {
            return nil
        }
        return UUID(uuidString: idString)
    }

    private var upcomingShifts: [ShiftModel] {
        guard let userId = currentUserId else { return [] }

        return store.shifts
            .filter { shift in
                shift.userId == userId && shift.end >= Date()
            }
            .sorted { first, second in
                first.start < second.start
            }
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                backgroundView(geo: geo)
                mainContent(geo: geo)
                backButtonOverlay(geo: geo)
            }
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }

    private func backgroundView(geo: GeometryProxy) -> some View {
        Image("pointseven")
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
            .ignoresSafeArea()
            .blur(radius: 1.5)
            .overlay(Color.black.opacity(0.22))
    }

    private func mainContent(geo: GeometryProxy) -> some View {
        VStack(spacing: 16) {
            Spacer()
                .frame(height: geo.safeAreaInsets.top + 50)

            headerView
            scheduleCard

            Spacer()
        }
        .padding(.horizontal, 18)
    }

    private var headerView: some View {
        VStack(spacing: 6) {
            Text("My Schedule")
                .font(.title.bold())
                .foregroundColor(.white)

            Text("Here you can view your upcoming shifts.")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.92))
                .multilineTextAlignment(.center)
        }
        .padding(.horizontal)
    }

    private var scheduleCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Upcoming Shifts")
                .font(.title3.bold())
                .foregroundColor(.black.opacity(0.85))

            if upcomingShifts.isEmpty {
                emptyStateView
            } else {
                shiftsListView
            }
        }
        .padding(16)
        .frame(maxWidth: 360)
        .background(Color.white.opacity(0.92))
        .cornerRadius(18)
    }

    private var emptyStateView: some View {
        VStack(spacing: 8) {
            Text("No shifts assigned yet")
                .font(.headline)
                .foregroundColor(.black.opacity(0.7))

            Text("When a manager adds a shift for you, it will appear here automatically.")
                .font(.subheadline)
                .foregroundColor(.black.opacity(0.55))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
    }

    private var shiftsListView: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(upcomingShifts) { shift in
                    shiftRow(shift)
                }
            }
        }
        .frame(maxHeight: 320)
    }

    private func shiftRow(_ shift: ShiftModel) -> some View {
        let positionText = (shift.position?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false)
            ? shift.position!
            : "Not specified"

        let locationText = (shift.location?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false)
            ? shift.location!
            : ""

        return VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(dayName(from: shift.start))
                    .font(.headline)
                    .foregroundColor(.black.opacity(0.85))

                Spacer()

                Text(dateText(from: shift.start))
                    .font(.subheadline)
                    .foregroundColor(.black.opacity(0.6))
            }

            Text("\(timeText(from: shift.start)) - \(timeText(from: shift.end))")
                .font(.subheadline)
                .foregroundColor(.black.opacity(0.75))

            HStack(spacing: 6) {
                Text("Position:")
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.black.opacity(0.75))

                Text(positionText)
                    .font(.subheadline)
                    .foregroundColor(.black.opacity(0.75))
            }

            if !locationText.isEmpty {
                HStack(spacing: 6) {
                    Text("Location:")
                        .font(.subheadline.weight(.semibold))
                        .foregroundColor(.black.opacity(0.75))

                    Text(locationText)
                        .font(.subheadline)
                        .foregroundColor(.black.opacity(0.75))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background(Color.white.opacity(0.55))
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
                        .foregroundColor(.black)
                        .frame(width: 46, height: 46)
                        .background(Color.white.opacity(0.9))
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

    private func dayName(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: date)
    }

    private func dateText(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: date)
    }

    private func timeText(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
}

#Preview {
    NavigationStack {
        MyScheduleView()
            .environmentObject(StorageManager.shared)
    }
}
