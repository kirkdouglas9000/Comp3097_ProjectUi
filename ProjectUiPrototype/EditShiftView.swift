//
//  EditShiftView.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-03-15.
//

import SwiftUI

struct EditShiftView: View {

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var shiftStore: ShiftStore

    var shift: Shift

    @State private var employeeName: String
    @State private var position: String
    @State private var date: String
    @State private var startTime: String
    @State private var endTime: String


    init(shift: Shift) {
        self.shift = shift
        _employeeName = State(initialValue: shift.employeeName)
        _position = State(initialValue: shift.position)
        _date = State(initialValue: shift.date)
        _startTime = State(initialValue: shift.startTime)
        _endTime = State(initialValue: shift.endTime)
    }


    var body: some View {

        VStack(spacing: 16) {

            Text("Edit Shift")
                .font(.title2.bold())

            TextField("Employee Name", text: $employeeName)
                .textFieldStyle(.roundedBorder)

            TextField("Position", text: $position)
                .textFieldStyle(.roundedBorder)

            TextField("Date", text: $date)
                .textFieldStyle(.roundedBorder)

            TextField("Start Time", text: $startTime)
                .textFieldStyle(.roundedBorder)

            TextField("End Time", text: $endTime)
                .textFieldStyle(.roundedBorder)

            Button("Save Changes") {
                updateShift()
                dismiss()
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding()
    }


    func updateShift() {

        if let index = shiftStore.shifts.firstIndex(where: { $0.id == shift.id }) {

            shiftStore.shifts[index].employeeName = employeeName
            shiftStore.shifts[index].position = position
            shiftStore.shifts[index].date = date
            shiftStore.shifts[index].startTime = startTime
            shiftStore.shifts[index].endTime = endTime
        }
    }
}
