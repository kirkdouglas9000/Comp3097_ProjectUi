//
//  ProjectUiPrototypeApp.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-02-07.
//

import SwiftUI

@main
struct ProjectUiPrototypeApp: App {
    
    @StateObject var shiftStore = ShiftStore()
    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environmentObject(shiftStore)
        }
    }
}
