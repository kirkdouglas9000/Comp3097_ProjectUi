//
//  Models.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-04-12.
//

import Foundation

struct User: Codable, Identifiable, Equatable, Hashable {
  var id = UUID()
  var name: String
  var email: String
  var username: String   
  var role: String
  var phone: String?
  var createdAt = Date()
}

struct ShiftModel: Codable, Identifiable, Equatable {
  var id = UUID()
  var userId: UUID
  var start: Date
  var end: Date
  var position: String?
  var location: String?
  var createdBy: UUID?
}

struct InventoryItemModel: Codable, Identifiable, Equatable {
  var id = UUID()
  var name: String
  var quantity: Int
  var unit: String?
  var lowStockThreshold: Int?
  var lastUpdated = Date()
}

struct AnnouncementModel: Codable, Identifiable, Equatable {
  var id = UUID()
  var title: String
  var body: String
  var postedBy: UUID?
  var createdAt = Date()
  var isPinned = false
}
