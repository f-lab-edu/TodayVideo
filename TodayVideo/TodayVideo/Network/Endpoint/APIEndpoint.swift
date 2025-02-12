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
    
    func getGenres(path: Path.RawValue) -> Endpoint<GenresResponse> {
        return Endpoint(path: path,
                        method: .get,
                        queryParameters: ["language":"ko"])
    }
    
    func getMovieGenres() -> Endpoint<GenresResponse> {
        return getGenres(path: Path.movieGenre.rawValue)
    }
    
    func getTVGenres() -> Endpoint<GenresResponse> {
        return getGenres(path: Path.TVGenre.rawValue)
    }
}
