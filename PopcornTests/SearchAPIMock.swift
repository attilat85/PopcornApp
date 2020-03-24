//
//  SearchAPIMock.swift
//  PopcornTests
//
//  Created by Atti's Macbbok pro on 24/03/2020.
//

import Foundation
import RxSwift
@testable import Popcorn

class SearchAPIMock: SearchAPI {
    
    var response: [String: Any]?
    
    func searchMovie(query: String, page: Int?) -> Single<Response> {
        return Single.create { event -> Disposable in
            
            return Disposables.create()
        }
    }
}
