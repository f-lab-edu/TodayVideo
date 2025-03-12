//
//  DetailResponse.swift
//  TodayVideo
//
//  Created by iOS Dev on 3/4/25.
//

import Foundation

protocol DetailResponse {
    var backdropPath: String? { get }
    var title: String? { get }
    var genres: [Genre]? { get }
    var date: String? { get }
    var runtime: Int? { get } // 영화 컨텐츠에서만 사용(DetailMovieResponse)
    var overview: String? { get }
}
