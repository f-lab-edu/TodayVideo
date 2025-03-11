//
//  APIEndpoint.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/3/25.
//

import Foundation

class APIEndpoint {
    static let shared = APIEndpoint()
    private init() {}
    
    enum Path: String {
        case movieGenre = "/genre/movie/list"
        case tvGenre = "/genre/tv/list"
        case movieDiscover = "/discover/movie"
        case tvDiscover = "/discover/tv"
    }
    
    // MARK: - 장르 선택 화면
    func getMovieGenres() -> Endpoint<GenresResponse> {
        return Endpoint(path: Path.movieGenre.rawValue,
                        method: .get,
                        queryParameters: ["language":"ko"])
    }
    
    func getTVGenres() -> Endpoint<GenresResponse> {
        return Endpoint(path: Path.tvGenre.rawValue,
                        method: .get,
                        queryParameters: ["language":"ko"])
    }
    
    // MARK: - 추천작 화면
    func getMovieDiscover(with model: RecommendRequest) -> Endpoint<RecommendMovieResponse> {
        return Endpoint(path: Path.movieDiscover.rawValue,
                        method: .get,
                        queryParameters: model)
    }
    
    func getTVDiscover(with model: RecommendRequest) -> Endpoint<RecommendTVResponse> {
        return Endpoint(path: Path.tvDiscover.rawValue,
                        method: .get,
                        queryParameters: model)
    }
}
