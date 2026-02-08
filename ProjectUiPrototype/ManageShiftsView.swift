//
//  ManageShiftsView.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-02-08.
//

import SwiftUI

struct ManageShiftsView: View {
    @State private var shiftName = ""
    @State private var shiftTime = ""

    var body: some View {
        ZStack {
            Image("pointseven")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 20) {

                Text("Manage Shifts")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                TextField("Shift Name", text: $shiftName)
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .padding(.horizontal)

                TextField("Shift Time", text: $shiftTime)
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .padding(.horizontal)

                Button(action: {}) {
                    Text("Add Shift")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(30)
                }
                .padding(.horizontal)

                Button(action: {}) {
                    Text("View All Shifts")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.brown.opacity(0.7))
                        .cornerRadius(30)
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding(.top, 50)
        }
    }
}
