//
//  TV.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/19/25.
//

import Foundation

class TV: ContentProtocol {
    typealias RecommendResponse = RecommendTVResponse
    
    let title: String = "TV 프로그램"
    let type: ContentType = .tv
    
    func genres() -> Endpoint<GenresResponse> {
        return APIEndpoint.shared.getTVGenres()
    }
    
    func recommend(page: Int) -> Endpoint<RecommendTVResponse> {
        let request = RecommendRequest().create(by: page)
        return APIEndpoint.shared.getTVDiscover(with: request)
    }
}
