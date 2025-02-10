//
//  APIEndpoint.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/3/25.
//

import Foundation

struct APIEndpoint {
    enum Path: String {
        case movieGenre = "/genre/movie/list"
        case TVGenre = "/genre/tv/list"
    }
    
    static func getMovieGenres() -> Endpoint<GenresResponse> {
        return Endpoint(path: Path.movieGenre.rawValue,
                        method: .get,
                        queryParameters: ["language":"ko"])
    }
    
    static func getTVGenres() -> Endpoint<GenresResponse> {
        return Endpoint(path: Path.TVGenre.rawValue,
                        method: .get,
                        queryParameters: ["language":"ko"])
    }
}
