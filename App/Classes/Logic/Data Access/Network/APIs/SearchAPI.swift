//
//  AuthAPI.swift
//  Core
//
//  Created by Botond Magyarosi on 16/10/2019.
//

import Foundation
import RestBird
import RxSwift
//import Alamofire

protocol SearchAPI {
    func searchMovie(query: String, page: Int?)  -> Single<Response>
}

class SearchAPIImpl: SearchAPI {
    private let networkClient: NetworkClient
       
    init(networkClient: NetworkClient) {
       self.networkClient = networkClient
    }
    
    // search Movies
    // GET 3/search/movie
    func searchMovie(query: String, page: Int? = 1)  -> Single<Response> {
        let request = Request(parameters: QueryDTO(query: query, page: page ?? 1, apiKey: API.apiKey))
         return networkClient.rx.execute(request: request)
    }
    
}

private struct Request: DataRequest {
    typealias RequestType = QueryDTO
    typealias ResponseType = Response
    
    let suffix: String? = API.Path.search
    let method: HTTPMethod = .get
    var parameters: QueryDTO?
}

// Dto for build up query. The fields will be encoded as parameters.
private struct QueryDTO: Encodable {
    let query: String
    let page: Int
    let apiKey:String
    
    enum CodingKeys: String, CodingKey {
        case query, page
        case apiKey   = "api_key"
    }
}
