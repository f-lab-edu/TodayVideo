//
//  DetailTVVideo.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/28/25.
//

import Foundation

// tv
struct DetailTVResponse: Decodable {
    let episodeRunTime: Int
    let firstAirDate: String
    let genres: [Item]
    let homepage: String
    let name: String
    let posterPath: String
    let voteAverage: Float
    
    enum CodingKeys: String, CodingKey {
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case genres
        case homepage
        case name
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
    
    struct Item: Decodable {
        let id: Int
        let name: String
    }
}
