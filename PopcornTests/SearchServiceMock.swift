//
//  SearchServiceMock.swift
//  PopcornTests
//
//  Created by Atti's Macbbok pro on 24/03/2020.
//

import Foundation
import RxSwift
@testable import Popcorn

class SearchServiceMock: SearchService {
    
    let searchAPI = SearchAPIMock(
    )
    func search(query: String, page: Int) -> Single<Response> {
        return searchAPI.searchMovie(query: query, page: page)
    }
}
