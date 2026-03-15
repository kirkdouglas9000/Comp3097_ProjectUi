//
//  ManageShiftsView.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-02-08.
//

import SwiftUI

struct ManageShiftsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var shiftName = ""
    @State private var shiftTime = ""
    
    @State private var shifts: [Shift] = []
    @State private var showShifts = false
    
    var body: some View {
        
        NavigationStack {
            
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
                
                
                Text("Manage Shifts")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                
                
                VStack(spacing: 16) {
                    
                    TextField("Shift Name", text: $shiftName)
                        .padding()
                        .background(Color.white.opacity(0.15))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                    
                    TextField("Shift Time", text: $shiftTime)
                        .padding()
                        .background(Color.white.opacity(0.15))
                        .cornerRadius(12)
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 24)
                
                
                Button(action: addShift) {
                    Text("Add Shift")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.orange)
                        .clipShape(Capsule())
                }
                .padding(.horizontal, 60)
                
                
                Button(action: {
                    showShifts = true
                }) {
                    Text("View All Shifts")
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.brown.opacity(0.75))
                        .clipShape(Capsule())
                }
                .padding(.horizontal, 60)
                
                
                Spacer()
            }
            .background(
                Image("pointseven")
                    .resizable()
                    .scaledToFill()
                    .blur(radius: 2)
                    .overlay(Color.black.opacity(0.15))
                    .ignoresSafeArea()
            )
            .navigationDestination(isPresented: $showShifts) {
                ShiftListView(shifts: shifts)
            }
        }
    }
    
    
    func addShift() {
        
        let newShift = Shift(name: shiftName, time: shiftTime)
        
        shifts.append(newShift)
        
        shiftName = ""
        shiftTime = ""
    }
}
