//
//  MovieData.swift
//  Movies
//
//  Created by Carlos Machado on 10/04/24.
//

import SwiftUI

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let releaseDate: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case backdropPath = "backdrop_path"
    }
}
