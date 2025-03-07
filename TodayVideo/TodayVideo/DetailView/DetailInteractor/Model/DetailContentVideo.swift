//
//  DetailContentVideo.swift
//  TodayVideo
//
//  Created by iOS Dev on 3/4/25.
//

import Foundation

// 영화, 드라마 공통 '비디오' response
struct DetailContentVideo: Decodable {
    let id: Int
    let results: [Item]
    
    struct Item: Decodable {
        let name: String
        let key: String
        let site: String
    }
}
