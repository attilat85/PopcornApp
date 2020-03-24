//
//  Component.swift
//  PopcornApp
//
//  Created by Atti's Macbbok pro on 21/03/2020.
//

import Foundation
import RestBird
import Alamofire

public final class CoreComponent {
    
    private lazy var networkClient: NetworkClient = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        let session = AlamofireSessionManager(config: APIConfiguration(), session: sessionManager)
        return NetworkClient(session: session)
    }()
    
    lazy private var searchAPI = SearchAPI(networkClient: networkClient)
    
    lazy var searchService: SearchService = SearchServiceImpl(searchAPI: searchAPI)
    lazy var homeService: HomeService = HomeServiceImpl()
    
    public init() {}
}

struct APIConfiguration: NetworkClientConfiguration {
    let baseUrl = API.backendURL

    let jsonEncoder = JSONEncoder()
    let jsonDecoder = JSONDecoder()
}
