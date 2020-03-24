//
//  HomeService.swift
//  PopcornApp
//
//  Created by Atti's Macbbok pro on 21/03/2020.
//

import Foundation
import RxSwift

private let jsonName = "trending_movies"

protocol HomeService {
    func fetchTrendingMovies() -> Single<[Movie]>
}

class HomeServiceImpl: HomeService {
    
    private let disposeBag = DisposeBag()
    
    init() {}
    
    // will fetch the thrending moview from a local json file
    func fetchTrendingMovies() -> Single<[Movie]> {
        return Single<[Movie]>.create { event -> Disposable in
            do {
                if let path = Bundle.main.path(forResource: jsonName, ofType: "json") {
                    let fileUrl = URL(fileURLWithPath: path)
                    // Getting data from JSON file using the file URL
                    let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                    let returnValue = try JSONDecoder().decode(Response.self, from: data)
                    event(.success(returnValue.results))
                } else {
                    event(.error(ReadError.fileNotFound))
                }
                
            } catch let error {
                event(.error(error))
            }
            
            return Disposables.create()
        }
    }
    
}

enum ReadError: Error {
    case fileNotFound
}
