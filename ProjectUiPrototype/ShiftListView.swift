//
//  ShiftListView.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-03-15.
//

import SwiftUI

struct ShiftListView: View {

    @EnvironmentObject var shiftStore: ShiftStore

    var body: some View {

        List {

            ForEach(shiftStore.shifts) { shift in

                NavigationLink {

                    EditShiftView(shift: shift)
                        .environmentObject(shiftStore)

                } label: {

                    VStack(alignment: .leading, spacing: 6) {

                        Text(shift.employeeName)
                            .font(.headline)

                        Text(shift.position)

                        Text(shift.date)

                        Text("\(shift.startTime) - \(shift.endTime)")
                            .foregroundColor(.gray)

                    }
                    .padding(.vertical, 6)
                }
            }
            .onDelete(perform: deleteShift)
        }
        .navigationTitle("All Shifts")
    }


    func deleteShift(at offsets: IndexSet) {
        shiftStore.shifts.remove(atOffsets: offsets)
    }
}
