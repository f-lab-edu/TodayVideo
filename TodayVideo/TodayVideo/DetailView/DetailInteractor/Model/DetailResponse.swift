//
//  DetailResponse.swift
//  TodayVideo
//
//  Created by iOS Dev on 3/4/25.
//

import Foundation

protocol DetailResponse {
    var backdropPath: String { get }
    var title: String { get }
    var genres: [Genre] { get }
    var date: String { get }
    var runtime: Int { get }
    var overview: String { get }
}
