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
    
    enum Path {
        case movieGenre
        case tvGenre
        case movieDiscover
        case tvDiscover
        case movieDetail(id: Int)
        case tvDetail(id: Int)
        case movieVideo(id: Int)
        case tvVideo(id: Int)
        
        var rawValue: String {
            switch self {
            case .movieGenre:
                return "/genre/movie/list"
            case .tvGenre:
                return "/genre/tv/list"
            case .movieDiscover:
                return "/discover/movie"
            case .tvDiscover:
                return "/discover/tv"
            case .movieDetail(let id):
                return "/movie/\(id)"
            case .tvDetail(let id):
                return "/tv/\(id)"
            case .movieVideo(let id):
                return "/movie/\(id)/videos"
            case .tvVideo(let id):
                return "/tv/\(id)/videos"
            }
        }
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
    
    // MARK: - 상세 화면
    func getMovieDetail(with id: Int) -> Endpoint<DetailMovieResponse> {
        return Endpoint(path: Path.movieDetail(id: id).rawValue,
                        method: .get,
                        queryParameters: ["language": "ko"])
    }
    
    func getTVDetail(with id: Int) -> Endpoint<DetailTVResponse> {
        return Endpoint(path: Path.tvDetail(id: id).rawValue,
                        method: .get,
                        queryParameters: ["language": "ko"])
    }
    
    func getMovieVideo(with id: Int) -> Endpoint<DetailContentVideo> {
        return Endpoint(path: Path.movieVideo(id: id).rawValue,
                        method: .get,
                        queryParameters: ["language": "ko"])
    }
    
    func getTvVideo(with id: Int) -> Endpoint<DetailContentVideo> {
        return Endpoint(path: Path.tvVideo(id: id).rawValue,
                        method: .get,
                        queryParameters: ["language": "ko"])
    }
}
