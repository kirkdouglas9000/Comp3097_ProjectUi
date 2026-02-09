//
//  MyScheduleView.swift
//  ProjectUiPrototype
//
//  Created by Andrei Gania on 2026-02-08.
//

import SwiftUI

struct MyScheduleView: View {
    struct Shift: Identifiable {
        let id = UUID()
        let day: String
        let time: String
        let isOff: Bool
    }

    private let shifts: [Shift] = [
        .init(day: "Monday", time: "9:00 AM – 5:00 PM", isOff: false),
        .init(day: "Tuesday", time: "10:00 AM – 6:00 PM", isOff: false),
        .init(day: "Wednesday", time: "OFF", isOff: true),
        .init(day: "Thursday", time: "8:00 AM – 4:00 PM", isOff: false),
        .init(day: "Friday", time: "12:00 PM – 8:00 PM", isOff: false),
        .init(day: "Saturday", time: "9:00 AM – 3:00 PM", isOff: false),
        .init(day: "Sunday", time: "OFF", isOff: true)
    ]

    var body: some View {
        ZStack {
            Image("pointseven")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 1.5)
                .overlay(Color.black.opacity(0.15))

            VStack(spacing: 14) {

                VStack(spacing: 6) {
                    Text("My Schedule")
                        .font(.title2.bold())
                        .foregroundColor(.white)

                    Text("Here you can view your upcoming shifts.")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                }
                .padding(.top, 12)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Weekly Schedule")
                        .font(.headline)
                        .foregroundColor(.black.opacity(0.85))

                    VStack(alignment: .leading, spacing: 6) {
                        ForEach(shifts) { shift in
                            HStack(spacing: 6) {
                                Text("\(shift.day):")
                                    .foregroundColor(shift.isOff ? .red : .black.opacity(0.75))

                                Text(shift.time)
                                    .foregroundColor(shift.isOff ? .red : .black.opacity(0.75))
                            }
                            .font(.subheadline)
                        }
                    }
                }
                .padding(16)
                .frame(maxWidth: 360)
                .background(Color.white.opacity(0.92))
                .cornerRadius(12)

                Button(action: {
                }) {
                    Text("Request Shift Change")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(Color(red: 0.25, green: 0.16, blue: 0.12).opacity(0.85))
                        .clipShape(Capsule())
                }
                .buttonStyle(.plain)
                .frame(maxWidth: 360)

                Spacer()
            }
            .padding(.horizontal, 18)
        }
        
    }
}

#Preview {
    NavigationStack {
        MyScheduleView()
    }
}
