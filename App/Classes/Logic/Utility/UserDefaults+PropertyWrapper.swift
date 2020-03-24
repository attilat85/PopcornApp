//
//  UserDefaults+PropertyWrapper.swift
//  iOS Starter Project
//
//  Created by Botond Magyarosi on 04/10/2019.
//  Copyright © 2018 Halcyon Mobile. All rights reserved.
//

import Foundation

@propertyWrapper
public struct UserDefault<T> {
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    public var wrappedValue: T {
        get { return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
}

@propertyWrapper
public struct UserDefaultCodable<T: Codable> {
    let key: String

    init(_ key: String) {
        self.key = key
    }

    public var wrappedValue: T? {
        get {
            guard let data = UserDefaults.standard.value(forKey: key) as? Data else { return nil }
            return try? JSONDecoder().decode(T.self, from: data)
        }
        set {
            UserDefaults.standard.set(try? JSONEncoder().encode(newValue), forKey: key)
        }
    }
}
