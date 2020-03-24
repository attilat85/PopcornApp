//
//  SearchService.swift
//  PopcornApp
//
//  Created by Atti's Macbbok pro on 21/03/2020.
//

import Foundation
import RxSwift

protocol SearchService {
    func search(query: String, page: Int) -> Single<Response>
}

class SearchServiceImpl: SearchService {
    
    private let searchAPI: SearchAPI
    private let disposeBag = DisposeBag()
    
    init(searchAPI: SearchAPI) {
        self.searchAPI = searchAPI
    }
    
    func search(query: String, page: Int) -> Single<Response> {
        return searchAPI.searchMoview(query: query, page: page)
    }
}
