//
//  DetailTVVideo.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/28/25.
//

import Foundation

// tv
struct DetailTVResponse: Decodable, DetailResponse {
    let runtime: Int
    let date: String
    let genres: [Genre]
    let homepage: String
    let title: String
    let backdropPath: String
    let voteAverage: Float
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case runtime = "episode_run_time"
        case date = "first_air_date"
        case genres
        case homepage
        case title = "name"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case overview
    }
}
