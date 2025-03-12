//
//  DetailMovieVideo.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/28/25.
//

import Foundation

struct DetailMovieResponse: Decodable, DetailResponse {
    let genres: [Genre]?
    let homepage: String
    let overview: String?
    let backdropPath: String?
    let productionCountries: [Production]
    let date: String?
    let runtime: Int?
    let title: String?
    let voteAverage: Float
    
    enum CodingKeys: String, CodingKey {
        case genres
        case homepage
        case overview
        case backdropPath = "backdrop_path"
        case productionCountries = "production_countries"
        case date = "release_date"
        case runtime
        case title
        case voteAverage = "vote_average"
    }
    
    struct Production: Decodable {
        let iso_3166_1: String
        let name: String
    }
}
