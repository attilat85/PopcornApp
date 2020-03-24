//
//  MovieViewModel.swift
//  PopcornApp
//
//  Created by Atti's Macbbok pro on 23/03/2020.
//

import Foundation

protocol MovieViewModel {
    var rateViewModel: RateViewModel { get }
    var imageUrl: URL? { get }
    var title: String { get }
    var year: String? { get }
    var genres: String { get }
    var description: String { get }
    
    func backButtonSelected()
}

class MovieViewModelImpl: MovieViewModel {
    let title: String
    let year: String?
    let genres: String
    let description: String
    let rateViewModel: RateViewModel
    let imageUrl: URL?
    
    weak var flowDelegate: FlowDelegate?
    
    init(movie: Movie) {
        title = movie.title
        year = movie.releaseDate?.date(with: .date)?.format(with: .year)
        rateViewModel = RateViewModelImpl(movie: movie)
        description = movie.overview
        genres = movie.detailText
        if let path = movie.posterPath {
            imageUrl = URL(string: "\(API.imagesUrl)\(path)")
        } else {
            imageUrl = nil
        }
    }
    
    // MARK: - Actiom
    
    func backButtonSelected() {
         self.flowDelegate?.didTapBack()
    }
    
}
