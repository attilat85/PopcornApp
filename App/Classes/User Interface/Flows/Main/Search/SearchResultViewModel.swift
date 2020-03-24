//
//  SearchViewModel.swift
//  PopcornApp
//
//  Created by Atti's Macbbok pro on 21/03/2020.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchResultViewModel {
    var hasLoadMore: Bool { get }
    var query: String { get }
    var cellModels: BehaviorRelay<[SearchResultCellViewModel]> { get }
    
    func loadMore()
    func backButtonSelected()
    func didSelectItem(at index: Int) 
}

protocol SearchResultFlowDelegate:FlowDelegate {
    func didSelect(movie: Movie)
}

class SearchResultViewModelImpl: SearchResultViewModel {
    
    weak var flowDelegate: SearchResultFlowDelegate?
    
    let cellModels = BehaviorRelay<[SearchResultCellViewModel]>(value: [])
    let query: String
    var hasLoadMore = true
    
    private let searchService: SearchService
    private var page = 1
    private let disposeBag = DisposeBag()
    private var movies: [Movie] = []
    
    init(query: String, searchService: SearchService) {
        self.query = query
        self.searchService = searchService
        
        fetchResult()
    }
    
    // MARK: - Load
    
    private func fetchResult() {
        searchService.search(query: query, page: page)
            .subscribe(onSuccess: {  [weak self] response in
                guard let `self` = self else { return }
                self.hasLoadMore = self.page < response.totalPages
                if response.results.isEmpty {
                    self.flowDelegate?.presentAlert(with: L10n.ooups, message: L10n.noMoviesFound, dismissed: {
                        self.flowDelegate?.didTapBack()
                    })
                } else {
                    self.movies += response.results
                    self.saveToSuggestions()
                    self.createCellModels()
                }
                
            }, onError: { [weak self] error in
                self?.flowDelegate?.showAlert(for: error)
            }).disposed(by: disposeBag)
    }
    
    func loadMore() {
        guard hasLoadMore else { return }
        page += 1
        fetchResult()
    }
    
    // MARK: - Actiom
    
    func backButtonSelected() {
         self.flowDelegate?.didTapBack()
    }
    
    func didSelectItem(at index: Int) {
        guard let movie = movies[safe: index] else { return }
        self.flowDelegate?.didSelect(movie: movie)
    }
    
    // MARK: - Logic
    
    private func createCellModels() {
        var models = cellModels.value
        for movie in movies {
            models.append(SearchResultCellViewModelImpl(movie: movie))
        }
        cellModels.accept(models)
    }
    
    private func saveToSuggestions() {
        var suggestions: [String] = KeyStore.suggestions ?? []
        if !suggestions.contains(query) {
            suggestions.append(query)
            KeyStore.suggestions = suggestions
        }
    }
    
}
