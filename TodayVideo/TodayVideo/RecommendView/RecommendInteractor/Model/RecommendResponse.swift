//
//  RecommendResponse.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/6/25.
//

import Foundation

protocol ContentRecommendResponse: Equatable {
    associatedtype Item: Decodable
    
    var results: [Item] { get }
    var totalPages: Int { get }
}

protocol RecommendItem {}

// 영화
struct RecommendMovieResponse: Decodable, ContentRecommendResponse {
    static func == (lhs: RecommendMovieResponse, rhs: RecommendMovieResponse) -> Bool {
        return lhs == rhs
    }
    
    typealias Item = Items
    
    let results: [Item]
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
    }

    struct Items: Decodable, RecommendItem {
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
struct RecommendTVResponse: Decodable, ContentRecommendResponse {
    static func == (lhs: RecommendTVResponse, rhs: RecommendTVResponse) -> Bool {
        return lhs == rhs
    }
    
    typealias Item = Items
    
    let results: [Item]
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
    }
    
    struct Items: Decodable, RecommendItem {
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
