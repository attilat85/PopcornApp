//
//  KeyStore.swift
//  Core
//
//  Created by Botond Magyarosi on 16/10/2019.
//

import Foundation

private enum Key {
    static let suggestions        = "suggestions"
}

enum KeyStore {

    @UserDefaultCodable(Key.suggestions)
    public static var suggestions: [String]?
    
}
