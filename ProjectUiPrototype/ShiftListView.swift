//
//  ShiftListView.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-03-15.
//

import SwiftUI

struct ShiftListView: View {

    var shifts: [Shift]

    var body: some View {

        List(shifts) { shift in

            VStack(alignment: .leading, spacing: 6) {

                Text(shift.employeeName)
                    .font(.headline)

                Text(shift.position)

                Text("\(shift.date)")

                Text("\(shift.startTime) - \(shift.endTime)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("All Shifts")
    }
}
