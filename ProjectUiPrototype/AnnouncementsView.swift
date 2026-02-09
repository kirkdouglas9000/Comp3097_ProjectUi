//
//  AnnouncementsView.swift
//  ProjectUiPrototype
//
//  Created by Andrei Gania on 2026-02-08.
//

import SwiftUI

struct AnnouncementsView: View {

    let announcements: [String] = ["Announcements", "New update", "New features", "go home"]

    var body: some View {
        ZStack {
            Image("pointseven")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: 1.5)
                .overlay(Color.black.opacity(0.15))

            VStack {
                Spacer()

                VStack(alignment: .leading, spacing: 16) {

                    Text("Announcements")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 18)

                    VStack(alignment: .leading, spacing: 12) {
                        ForEach(announcements, id: \.self) { item in
                            Text(item)
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.9))
                        }
                    }
                    .padding(.horizontal, 24)

                    Spacer()
                }
                .frame(maxWidth: 360)
                .frame(maxHeight: 560)
                .background(Color(red: 0.25, green: 0.16, blue: 0.12).opacity(0.92))
                .cornerRadius(28)
                .padding(.horizontal, 18)

                Spacer()
            }
        }
    
    }
}

#Preview {
    NavigationStack {
        AnnouncementsView()
    }
}
