//
//  PopcornTests.swift
//  PopcornTests
//
//  Created by Atti's Macbbok pro on 24/03/2020.
//

import XCTest

class PopcornTests: XCTestCase {
    
    let response: [String: Any] = [
        "page": 1,
        "total_results": 6,
        "total_pages": 1,
        "results": [
            "popularity": 29.758,
            "id": 272,
            "video": false,
            "vote_count": 13723,
            "vote_average": 7.6,
            "title": "Batman Begins",
            "release_date": "2005-06-10",
            "original_language": "en",
            "original_title": "Batman Begins",
            "genre_ids": [
                28,
                80,
                18
            ],
            "backdrop_path": "/9myrRcegWGGp24mpVfkD4zhUfhi.jpg",
            "adult": false,
            "overview": "Driven by tragedy, billionaire Bruce Wayne dedicates his life to uncovering and defeating the corruption that plagues his home, Gotham City.  Unable to work within the system, he instead creates a new identity, a symbol of fear for the criminal underworld - The Batman.",
            "poster_path": "/dr6x4GyyegBWtinPBzipY02J2lV.jpg"
        ]
    ]

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
