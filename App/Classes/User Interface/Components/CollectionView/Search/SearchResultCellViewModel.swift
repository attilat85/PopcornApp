//
//  SearchResultCellViewModel.swift
//  PopcornApp
//
//  Created by Atti's Macbbok pro on 22/03/2020.
//

import Foundation
import UIKit

protocol SearchResultCellViewModel {
    var rateViewModel: RateViewModel { get }
    var imageUrl: URL? { get }
    var title: String { get }
    var year: String? { get }
    var footer: String? { get }
}

class SearchResultCellViewModelImpl: SearchResultCellViewModel {
    
    let rateViewModel: RateViewModel
    let imageUrl: URL?
    let title: String
    var year: String?
    var footer: String?
    
    // setups fields needed for cell to display on UI
    init(movie: Movie) {
        rateViewModel = RateViewModelImpl(movie: movie)
        title = movie.title
        year = movie.releaseDate?.date(with: .date)?.format(with: .year)
        
        if let path = movie.posterPath {
            imageUrl = URL(string: "\(API.imagesUrl)\(path)")
        } else {
            imageUrl = nil
        }
        
        footer = movie.detailText
    }
}
