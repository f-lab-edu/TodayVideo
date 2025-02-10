//
//  APIEndpoint.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/3/25.
//

import Foundation

class APIEndpoint {
    static let shared = APIEndpoint()
    
    enum Path: String {
        case movieGenre = "/genre/movie/list"
        case TVGenre = "/genre/tv/list"
    }
    
    func getMovieGenres() -> Endpoint<GenresResponse> {
        return Endpoint(path: Path.movieGenre.rawValue,
                        method: .get,
                        queryParameters: ["language":"ko"])
    }
    
    func getTVGenres() -> Endpoint<GenresResponse> {
        return Endpoint(path: Path.TVGenre.rawValue,
                        method: .get,
                        queryParameters: ["language":"ko"])
    }
}
