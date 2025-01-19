//
//  Genre.swift
//  TodayVideo
//
//  Created by 김지나 on 1/19/25.
//

import Foundation

struct GenresRequest: Encodable {
  let language: String = "ko"
}

struct GenresResponse: Decodable {
  let id: Int
  let name: String
}
