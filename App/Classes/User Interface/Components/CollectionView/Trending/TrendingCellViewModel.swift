//
//  TrendingCellViewModel.swift
//  PopcornApp
//
//  Created by Atti's Macbbok pro on 21/03/2020.
//

import Foundation
import UIKit

protocol TrendingCellViewModel {
    var url: URL { get }
    
}

class TrendingCellViewModelImpl: TrendingCellViewModel {
    
    let url: URL
    
    init?(posterPath: String) {
        guard let url = URL(string: "\(API.imagesUrl)\(posterPath)") else {return nil }
        self.url = url
    }
}
