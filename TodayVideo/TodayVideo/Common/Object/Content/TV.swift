//
//  TV.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/19/25.
//

import Foundation

class TV: ContentProtocol {
    typealias RecommendResponse = RecommendTVResponse
    typealias DetailResponse = DetailTVResponse
    
    static let shared = TV()
    private init() {}
    
    let title: String = "TV 프로그램"
    let type: ContentType = .tv
    
    func genres() -> Endpoint<GenresResponse> {
        return APIEndpoint.shared.getTVGenres()
    }
    
    func recommend(page: Int) -> Endpoint<RecommendTVResponse> {
        let request = RecommendRequest().create(by: page)
        return APIEndpoint.shared.getTVDiscover(with: request)
    }
    
    func detail(id: Int) -> Endpoint<DetailTVResponse> {
        return APIEndpoint.shared.getTVDetail(with: id)
    }
    
    func video(id: Int) -> Endpoint<DetailContentVideo> {
        return APIEndpoint.shared.getTvVideo(with: id)
    }
}
