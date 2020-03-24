//
//  RateVIewModel.swift
//  PopcornApp
//
//  Created by Atti's Macbbok pro on 23/03/2020.
//

import Foundation
import UIKit

protocol RateViewModel {
    var avgRate:  NSAttributedString? { get }
    var rateCount: String { get }
}

class RateViewModelImpl: RateViewModel {
    
    var avgRate:  NSAttributedString?
    var rateCount: String
    
    init(movie: Movie) {
        
        rateCount = "\(movie.voteCount)"
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.roundingMode = .halfEven
        formatter.maximumFractionDigits = 1
        
        if let avgRateString = formatter.string(for: movie.voteAverage) {
            let string = "\(avgRateString) / 10"
            let mutableString = NSMutableAttributedString(string: string, attributes: [.font: Font.regular(size: .small), .foregroundColor: UIColor.lightGray])
            mutableString.addAttributes([.font: Font.regular(size: .mediumSmall), .foregroundColor: UIColor.black], range: NSRange(string.range(of: avgRateString)!, in: string))
            avgRate = mutableString
        }
    }
}
