//
//  PopcornTests.swift
//  PopcornTests
//
//  Created by Atti's Macbbok pro on 24/03/2020.
//

import XCTest
import RxSwift
@testable import Popcorn

class PopcornTests: XCTestCase {
    
    let searchService = SearchServiceMock()
    let disposeBag = DisposeBag()
    
    func testEmptyResponse() {
        searchService.searchAPI.fileName = "empty_response"
        searchService.search(query: "test", page: 1).subscribe(onSuccess: { response in
            XCTAssertTrue(response.results.isEmpty, "The response is empty!")
            XCTAssertFalse(!response.results.isEmpty, "The response should be empty!")
        }, onError: { error in
            XCTFail(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
    
    func testValidResponse() {
        searchService.searchAPI.fileName = "valid_response"
        searchService.search(query: "test", page: 1).subscribe(onSuccess: { response in
            XCTAssertTrue(!response.results.isEmpty, "The response shouldn't be empty!")
            XCTAssertFalse(response.results.isEmpty, "The response should be empty!")
        }, onError: { error in
            XCTFail(error.localizedDescription)
        }).disposed(by: disposeBag)
    }

}
