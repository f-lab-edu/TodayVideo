//
//  Movie.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/19/25.
//

import Foundation

class Movie: ContentProtocol {
    typealias RecommendResponse = RecommendMovieResponse
    
    let title: String = "영화"
    let type: ContentType = .movie
    
    func genres() -> Endpoint<GenresResponse> {
        return APIEndpoint.shared.getMovieGenres()
    }
    
    func recommend(page: Int) -> Endpoint<RecommendMovieResponse> {
        let request = RecommendRequest().create(by: page)
        return APIEndpoint.shared.getMovieDiscover(with: request)
    }
}
