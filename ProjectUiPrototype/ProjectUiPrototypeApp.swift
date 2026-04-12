//
//  ProjectUiPrototypeApp.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-02-07.
//  101401017

import SwiftUI
@main
struct ProjectUiPrototypeApp: App {
    @StateObject private var store = StorageManager.shared
    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environmentObject(store)
        }
    }
}
