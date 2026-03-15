//
//  MyScheduleView.swift
//  ProjectUiPrototype
//
//  Created by Andrei Gania on 2026-02-08.
//

import SwiftUI

struct MyScheduleView: View {
    
    @EnvironmentObject var shiftStore: ShiftStore
    
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
                    
                    Text("Upcoming Shifts")
                        .font(.headline)
                        .foregroundColor(.black.opacity(0.85))
                    
                    
                    VStack(alignment: .leading, spacing: 8) {
                        
                        if shiftStore.shifts.isEmpty {
                            
                            Text("No shifts scheduled")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                            
                        } else {
                            
                            ForEach(shiftStore.shifts) { shift in
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    
                                    Text(shift.employeeName)
                                        .font(.headline)
                                    
                                    Text(shift.position)
                                        .font(.subheadline)
                                    
                                    Text(shift.date)
                                        .font(.subheadline)
                                    
                                    Text("\(shift.startTime) - \(shift.endTime)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                
                                Divider()
                            }
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
            .environmentObject(ShiftStore())
    }
}
