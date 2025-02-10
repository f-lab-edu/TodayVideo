//
//  Genre.swift
//  TodayVideo
//
//  Created by 김지나 on 1/19/25.
//

import Foundation

struct GenresResponse: Decodable, Equatable {
    let genres: [Genre]
}

struct Genre: Codable, Equatable {
    let id: Int?
    let name: String?
}
