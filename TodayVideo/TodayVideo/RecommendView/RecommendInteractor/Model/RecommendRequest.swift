//
//  RecommendRequest.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/26/25.
//

import Foundation

struct RecommendRequest: Codable, Equatable {
    var language: String = "ko-KR"
    var page: Int32? // 1 부터
    var voteCount: Float = 7
    var watchRegion: String = "KR"
    var withGenres: String?
    var withWatchProviders: String = "8" // 넷플릭스
    
    init(page: Int32? = nil, withGenres: String? = nil) {
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
    
    func create(by page: Int) -> RecommendRequest {
        let page = Int.random(in: 1 ... page)
        let genre = UserDefault.shared.stringForKey(.selectGenre) ?? ""
        
        return RecommendRequest(page: Int32(page), withGenres: genre)
    }
}
