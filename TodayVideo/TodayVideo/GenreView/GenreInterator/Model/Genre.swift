//
//  Genre.swift
//  TodayVideo
//
//  Created by 김지나 on 1/19/25.
//

import Foundation

struct GenresResponse: Decodable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int?
    let name: String?
}
