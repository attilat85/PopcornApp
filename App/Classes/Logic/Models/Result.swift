//
//  Authorization.swift
//  iOS Starter Project
//
//  Created by Halcyon Mobile on 08/01/2019.
//

import Foundation

public struct Response: Decodable {
    let page: Int
    let totalPages: Int
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
    }
}
