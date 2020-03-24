//
//  User.swift
//  iOS Starter Project
//
//  Created by Halcyon Mobile on 12/03/2017.
//  Copyright © 2017 Halcyon Mobile. All rights reserved.
//

import Foundation

// in normal cases this would be downloaded from an api
private let genres: [Int: String] = [28: "Action", 12: "Adventure", 16:"Animation",
                                     35: "Comedy", 80: "Crime", 99: "Documentary",
                                     18: "Drama", 10751: "Family", 14: "Fantasy",
                                     36: "History", 27: "Horror", 10402: "Music",
                                     9648: "Mystery", 10749: "Romance", 878: "Science Fiction",
                                     10770: "TV Movie", 53: "Thriller", 10752: "War", 37: "Western"]

public class Movie: Decodable {
    
    let id: Int 
    let popularity: Double
    let video: Bool
    let adult: Bool
    let title: String
    let overview: String
    let voteCount: Int
    let posterPath: String?
    let backdropPath: String?
    let originalLanguage: String
    let originalTitle: String
    let genreIds: [Int]
    let voteAverage: Double
    let releaseDate: String?
   
    enum CodingKeys: String, CodingKey {
        case popularity, video, id, adult, title, overview
        case voteCount = "vote_count"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIds = "genre_ids"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
    
    lazy var detailText: String = {
        var genres: [String] = []
        self.genreIds.forEach { id in
            if let genre = self.genre(for: id) {
                genres.append(genre)
            }
        }
        
        let genresString = genres.joined(separator: ", ")
        let date = self.releaseDate?.date(with: .date)?.format(with: .longDate)
        
        var footer: String = ""
        if genresString.isEmpty {
            footer = date ?? ""
        } else if let date = date {
            footer = "\(genresString) | \(date)"
        } else {
            footer = genresString
        }
        return footer
    }()
    
    private func genre(for id: Int) -> String? {
        genres[id]
    }

}
