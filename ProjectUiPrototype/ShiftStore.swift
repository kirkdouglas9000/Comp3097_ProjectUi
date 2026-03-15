//
//  ShiftStore.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-03-15.
//

import Foundation
import SwiftUI
import Combine

class ShiftStore: ObservableObject {

    @Published var shifts: [Shift] = []

}
