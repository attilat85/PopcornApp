//
//  HomeViewModel.swift
//  PopcornApp
//
//  Created by Atti's Macbbok pro on 21/03/2020.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeViewModel {
    var cellModels: BehaviorRelay<[TrendingCellViewModel]> { get }
    var suggestions: [String] { get }
    
    func search(text: String)
    func updateSuggestions()
    func didSelectItem(at index: Int)
}

protocol HomeFlowDelegate: FlowDelegate {
    func search(text: String)
    func didSelect(movie: Movie)
}

class HomeViewModelImpl: HomeViewModel {
    
    weak var flowDelegate: HomeFlowDelegate?
    
    var suggestions: [String]
    let cellModels = BehaviorRelay<[TrendingCellViewModel]>(value: [])
    
    private let homeService: HomeService
    private var trendingMovies: [Movie] = []
    private let disposeBag = DisposeBag()
    
    init(homeService: HomeService) {
        self.homeService = homeService
        self.suggestions = KeyStore.suggestions ?? []
        loadData()
    }
    
    private func loadData() {
        homeService.fetchTrendingMovies().subscribe(onSuccess: { [weak self] movies in
            self?.trendingMovies = movies
            let models: [TrendingCellViewModel] = movies.compactMap {  $0.posterPath != nil ? TrendingCellViewModelImpl(posterPath: $0.posterPath!) : nil }
            self?.cellModels.accept(models)
            
        }, onError: { [weak self] error in
            self?.flowDelegate?.showAlert(for: error)
        }).disposed(by: disposeBag)
    }
    
    func search(text: String) {
        flowDelegate?.search(text: text)
    }
    
    func updateSuggestions() {
        self.suggestions = KeyStore.suggestions ?? []
    }
    
    func didSelectItem(at index: Int) {
        guard let movie = trendingMovies[safe: index] else { return }
        self.flowDelegate?.didSelect(movie: movie)
    }
}
