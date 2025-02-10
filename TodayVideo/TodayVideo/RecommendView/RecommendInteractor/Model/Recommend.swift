//
//  Recommend.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/6/25.
//

import Foundation

// MARK: - request
struct RecommendRequest: Codable, Equatable {
    var language: String = "ko-KR"
    var page: Int32 // 1 부터
    var voteCount: Float = 7
    var watchRegion: String = "KR"
    var withGenres: String
    var withWatchProviders: String = "8" // 넷플릭스
    
    init(page: Int32, withGenres: String) {
        self.page = page
        self.withGenres = withGenres
    }
    
    enum CodingKeys: String, CodingKey {
        case language
        case page
        case voteCount = "vote_count.gte"
        case watchRegion = "watch_region"
        case withGenres = "with_genres"
        case withWatchProviders = "with_watch_providers"
    }
}

// MARK: - response
// 영화
struct RecommendMovieResponse: Decodable, Equatable {
    let results: [Items]
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
    }
    
    static func == (lhs: RecommendMovieResponse, rhs: RecommendMovieResponse) -> Bool {
        return lhs.results == rhs.results
    }
    
    struct Items: Decodable, Equatable {
        let genreIds: [Int]
        let id: Int
        let posterPath: String
        let title: String
        let releaseDate: String
        
        enum CodingKeys: String, CodingKey {
            case genreIds = "genre_ids"
            case id
            case posterPath = "poster_path"
            case title
            case releaseDate = "release_date"
        }
    }
}

// 드라마
struct RecommendTVResponse: Decodable, Equatable {
    let results: [Items]
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
    }
    
    static func == (lhs: RecommendTVResponse, rhs: RecommendTVResponse) -> Bool {
        return lhs.results == rhs.results
    }
    
    struct Items: Decodable, Equatable {
        let genreIds: [Int]
        let id: Int
        let posterPath: String
        let name: String
        let firstAirDate: String

        enum CodingKeys: String, CodingKey {
            case genreIds = "genre_ids"
            case id
            case posterPath = "poster_path"
            case name
            case firstAirDate = "first_air_date"
        }
    }
}
