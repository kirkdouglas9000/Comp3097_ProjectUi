//
//  ManageShiftsView.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-02-08.
//
import SwiftUI

struct ManageShiftsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var employeeName = ""
    @State private var position = ""
    
    @State private var shiftDate = Date()
    @State private var startTime = Date()
    @State private var endTime = Date()
    
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
                    
                    TextField("Employee Name", text: $employeeName)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .foregroundColor(.black)

                    TextField("Position (Barista, Cashier, etc)", text: $position)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .foregroundColor(.black)
                    
                    
                    VStack(alignment: .leading) {
                        
                        Text("Shift Date")
                            .foregroundColor(.white)
                            .font(.headline)
                        
                        DatePicker(
                            "",
                            selection: $shiftDate,
                            displayedComponents: [.date]
                        )
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .padding()
                        .background(Color.white.opacity(0.25))
                        .cornerRadius(12)
                    }
                    
                    
                    VStack(alignment: .leading) {
                        
                        Text("Start Time")
                            .foregroundColor(.white)
                            .font(.headline)
                        
                        DatePicker(
                            "",
                            selection: $startTime,
                            displayedComponents: [.hourAndMinute]
                        )
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .padding()
                        .background(Color.white.opacity(0.25))
                        .cornerRadius(12)
                    }
                    
                    
                    VStack(alignment: .leading) {
                        
                        Text("End Time")
                            .foregroundColor(.white)
                            .font(.headline)
                        
                        DatePicker(
                            "",
                            selection: $endTime,
                            displayedComponents: [.hourAndMinute]
                        )
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .padding()
                        .background(Color.white.opacity(0.25))
                        .cornerRadius(12)
                    }
                    
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
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
    
    
    func addShift() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        
        
        let newShift = Shift(
            employeeName: employeeName,
            position: position,
            date: dateFormatter.string(from: shiftDate),
            startTime: timeFormatter.string(from: startTime),
            endTime: timeFormatter.string(from: endTime)
        )
        
        
        shifts.append(newShift)
        
        
        employeeName = ""
        position = ""
    }
}
