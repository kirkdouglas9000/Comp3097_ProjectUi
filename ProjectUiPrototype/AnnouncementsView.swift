//
//  AnnouncementsView.swift
//  ProjectUiPrototype
//
//  Created by Andrei Gania on 2026-02-08.
//  101478350
import SwiftUI

struct AnnouncementsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var store: StorageManager

    private var liveAnnouncements: [AnnouncementModel] {
        store.announcements.reversed()
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
                    .overlay(Color.black.opacity(0.22))

                VStack {
                    Spacer()

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Announcements")
                            .font(.title.bold())
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 18)

                        if liveAnnouncements.isEmpty {
                            VStack(spacing: 10) {
                                Text("No announcements yet")
                                    .font(.headline)
                                    .foregroundColor(.white)

                                Text("When a manager posts an announcement, it will appear here automatically.")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.8))
                                    .multilineTextAlignment(.center)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 40)

                        } else {
                            ScrollView {
                                VStack(spacing: 12) {
                                    ForEach(liveAnnouncements) { announcement in
                                        announcementCard(announcement)
                                    }
                                }
                                .padding(.horizontal, 2)
                                .padding(.bottom, 8)
                            }
                        }

                        Spacer(minLength: 0)
                    }
                    .padding(.horizontal, 18)
                    .padding(.bottom, 18)
                    .frame(maxWidth: 360)
                    .frame(maxHeight: 560)
                    .background(Color(red: 0.25, green: 0.16, blue: 0.12).opacity(0.92))
                    .cornerRadius(28)
                    .padding(.horizontal, 18)

                    Spacer()
                }

                VStack {
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                                .frame(width: 44, height: 44)
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
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }

    private func announcementCard(_ announcement: AnnouncementModel) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(announcement.title)
                .font(.headline)
                .foregroundColor(.white)

            Text(announcement.body)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.88))
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.10))
        .cornerRadius(14)
    }
}

#Preview {
    NavigationStack {
        AnnouncementsView()
            .environmentObject(StorageManager.shared)
    }
}
