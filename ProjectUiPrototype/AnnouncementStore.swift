//
//  AnnouncementStore.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-03-15.
//
import SwiftUI
import Combine

class AnnouncementStore: ObservableObject {

    @Published var announcements: [Announcement] = []

}
