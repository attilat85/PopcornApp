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
    
    var fileName: String?
    
    func searchMovie(query: String, page: Int?) -> Single<Response> {
        return Single.create { event -> Disposable in
            do {
                if let fileName = self.fileName {
                    let data = try self.loadData(jsonName: fileName)
                    let returnValue = try JSONDecoder().decode(Response.self, from: data)
                    event(.success(returnValue))
                } else {
                    event(.error(TestError.emptyFileName))
                }
            } catch let error {
                event(.error(error))
            }
            return Disposables.create()
        }
    }
    
    private func loadData(jsonName name: String) throws -> Data {
        guard let path = Bundle(for: PopcornTests.self).path(forResource: name, ofType: "json") else { throw TestError.jsonResourceNotFound(jsonFilename: name) }
        
        let url = URL(fileURLWithPath: path)
        return try Data(contentsOf: url)
    }

}

enum TestError: Error {
    case emptyFileName
    case jsonResourceNotFound(jsonFilename: String)
    
    public var errorDescription: String? {
        switch self {
        case .emptyFileName:
            return "File name is not set!"
        case .jsonResourceNotFound(let name):
            return "File at with name: \(name) doesn't exist!"
        }
    }
}
