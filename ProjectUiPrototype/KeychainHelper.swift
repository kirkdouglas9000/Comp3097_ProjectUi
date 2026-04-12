//
//  KeychainHelper.swift
//  ProjectUiPrototype
//
//  Created by Kirk on 2026-04-12.
//

import Foundation
import Security
final class KeychainHelper {
  static let shared = KeychainHelper()
  private init() {}
  func save(_ data: Data, service: String, account: String) {
    let query: [CFString: Any] = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrService: service,
      kSecAttrAccount: account,
      kSecValueData: data
    ]
    SecItemDelete(query as CFDictionary)
    SecItemAdd(query as CFDictionary, nil)
  }
  func read(service: String, account: String) -> Data? {
    let query: [CFString: Any] = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrService: service,
      kSecAttrAccount: account,
      kSecReturnData: true,
      kSecMatchLimit: kSecMatchLimitOne
    ]
    var result: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &result)
    guard status == errSecSuccess else { return nil }
    return result as? Data
  }
  func delete(service: String, account: String) {
    let query: [CFString: Any] = [
      kSecClass: kSecClassGenericPassword,
      kSecAttrService: service,
      kSecAttrAccount: account
    ]
    SecItemDelete(query as CFDictionary)
  }
}
