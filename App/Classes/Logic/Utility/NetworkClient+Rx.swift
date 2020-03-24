//
//  NetworkClient+Rx.swift
//  Core
//
//  Created by Noemi Kalman on 06/11/2019.
//

import RestBird
import RxSwift

extension NetworkClient: ReactiveCompatible {}

extension Reactive where Base: NetworkClient {

    // MARK: - Data request
    
    public func execute<Request: DataRequest>(request: Request) -> Single<Void> where Request.ResponseType == EmptyResponse {
        return Single.create { [base] event -> Disposable in
            base.execute(request: request) {  (result: Result<Void, Error>) in
                switch result {
                case .success: event(.success(()))
                case .failure(let error): event(.error(error))
                }
            }
            return Disposables.create()
        }
    }

    public func execute<Request: DataRequest>(request: Request) -> Single<Request.ResponseType> {
        return Single.create { [base] event -> Disposable in
            base.execute(request: request) {  (result: Result<Request.ResponseType, Error>) in
                switch result {
                case .success(let result): event(.success((result)))
                case .failure(let error): event(.error(error))
                }
            }
            return Disposables.create()
        }
    }
    
    // MARK: - Multipart
    
    public func execute<Request: MultipartRequest>(request: Request) -> Single<Void> where Request.ResponseType == EmptyResponse {
        return Single.create { [base] event -> Disposable in
            base.execute(request: request, uploadProgress: nil) {  (result: Result<Void, Error>) in
                switch result {
                case .success: event(.success(()))
                case .failure(let error): event(.error(error))
                }
            }
            return Disposables.create()
        }
    }
    
    public func execute<Request: MultipartRequest>(request: Request) -> Single<Request.ResponseType> {
        return Single.create { [base] event -> Disposable in
            base.execute(request: request, uploadProgress: nil) {  (result: Result<Request.ResponseType, Error>) in
                switch result {
                case .success(let result): event(.success((result)))
                case .failure(let error): event(.error(error))
                }
            }
            return Disposables.create()
        }
    }
}
