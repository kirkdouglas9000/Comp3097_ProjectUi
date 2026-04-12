//
//  PasswordHelper.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-04-12.
//  101401017

import Foundation
import CryptoKit
func hashPassword(_ password: String) -> String {
  let data = Data(password.utf8)
  let hashed = SHA256.hash(data: data)
  return hashed.compactMap { String(format: "%02x", $0) }.joined()
}
