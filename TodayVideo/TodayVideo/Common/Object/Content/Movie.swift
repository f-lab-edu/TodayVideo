//
//  Movie.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/19/25.
//

import Foundation

class Movie: ContentProtocol {
    typealias RecommendResponse = RecommendMovieResponse
    typealias DetailResponse = DetailMovieResponse
    
    static let shared = Movie()
    private init() {}
    
    let title: String = "영화"
    let type: ContentType = .movie
    
    func genres() -> Endpoint<GenresResponse> {
        return APIEndpoint.shared.getMovieGenres()
    }
    
    func recommend(page: Int) -> Endpoint<RecommendResponse> {
        let request = RecommendRequest().create(by: page)
        return APIEndpoint.shared.getMovieDiscover(with: request)
    }
    
    func detail(id: Int) -> Endpoint<DetailResponse> {
        return APIEndpoint.shared.getMovieDetail(with: id)
    }
    
    func video(id: Int) -> Endpoint<DetailContentVideo> {
        return APIEndpoint.shared.getMovieVideo(with: id)
    }
}
