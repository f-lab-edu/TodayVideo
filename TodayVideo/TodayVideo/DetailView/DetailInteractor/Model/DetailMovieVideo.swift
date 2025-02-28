//
//  DetailMovieVideo.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/28/25.
//

import Foundation

struct DetailMovieResponse: Decodable {
    let genres: [Item]
    let homepage: String
    let overview: String
    let posterPath: String
    let productionCountries: [Production]
    let releaseDate: String
    let runtime: Int
    let title: String
    let voteAverage: Float
    
    enum CodingKeys: String, CodingKey {
        case genres
        case homepage
        case overview
        case posterPath = "poster_path"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case runtime
        case title
        case voteAverage = "vote_average"
    }
    
    struct Item: Decodable {
        let id: Int
        let name: String
    }
    
    struct Production: Decodable {
        let iso_3166_1: String
        let name: String
    }
}

// MARK: - 영화, 드라마 공통 비디오 response
struct DetailContentVideo: Decodable {
    let id: Int
    let results: [Item] // [] 이렇게 들어올 때?
    
    struct Item: Decodable {
        let name: String
        let key: String
        let site: String
    }
}
