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
    @StateObject var announcementStore = AnnouncementStore()
    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environmentObject(shiftStore)
                .environmentObject(announcementStore)
        }
    }
}
