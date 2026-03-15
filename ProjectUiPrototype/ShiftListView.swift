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
            
            VStack(alignment: .leading) {
                Text(shift.name)
                    .font(.headline)
                
                Text(shift.time)
                    .font(.subheadline)
            }
        }
        .navigationTitle("All Shifts")
    }
}
