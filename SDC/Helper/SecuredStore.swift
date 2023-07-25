//
//  SecuredStore.swift
//  SDC
//
//  Created by Razan Barq on 26/07/2023.
//

import Foundation
import Security

public struct SecuredStore {
    
    fileprivate var defaultClassAndAttributes: [String: AnyObject] {
        return [
            String(kSecClass): String(kSecClassGenericPassword) as AnyObject,
            String(kSecAttrAccessible): String(kSecAttrAccessibleAfterFirstUnlock) as AnyObject,
            String(kSecAttrService): service as AnyObject,
        ]
    }
    
    public let service: String
    
    
    // Set
    public func setData(_ data: Data, forKey key: String) {
        var attributes = defaultClassAndAttributes
        attributes[String(kSecAttrAccount)] = key as AnyObject?
        attributes[String(kSecValueData)] = data as AnyObject?
        SecItemAdd(attributes as CFDictionary, nil)
    }
    
    public func setValue(_ value: String, forKey key: String) {
        if let data = value.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            setData(data, forKey: key)
        }
    }
    
    // Get
    public func dataForKey(_ key: String) -> Data? {
        var attributes = defaultClassAndAttributes
        attributes[String(kSecAttrAccount)] = key as AnyObject?
        attributes[String(kSecMatchLimit)] = kSecMatchLimitOne
        attributes[String(kSecReturnData)] = true as AnyObject?
        
        var result: AnyObject?
        let status = withUnsafeMutablePointer(to: &result) { pointer in
            return SecItemCopyMatching(attributes as CFDictionary, UnsafeMutablePointer(pointer))
        }
        
        guard status == errSecSuccess else {
            return nil
        }
        
        return result as? Data
    }
    
    public func valueForKey(_ key: String) -> String? {
        return dataForKey(key).flatMap { data in
            String(data: data, encoding: String.Encoding.utf8)
        }
    }
    
    // Update
    public func updateData(_ data: Data, forKey key: String) {
        var query = defaultClassAndAttributes
        query[String(kSecAttrAccount)] = key as AnyObject?
        
        var attributesToUpdate = query
        attributesToUpdate[String(kSecClass)] = nil
        attributesToUpdate[String(kSecValueData)] = data as AnyObject?
        
        let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
        if status == errSecItemNotFound || status == errSecNotAvailable {
            setData(data, forKey: key)
        }
    }
    
    public func updateValue(_ value: String, forKey key: String) {
        if let data = value.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            updateData(data, forKey: key)
        }
    }
    
    // Remove
    public func removeValueForKey(_ key: String) {
        var attributes = defaultClassAndAttributes
        attributes[String(kSecAttrAccount)] = key as AnyObject?
        SecItemDelete(attributes as CFDictionary)
    }
}
