//
//  Content.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/11/25.
//

import Foundation

enum ContentType {
    case movie
    case tv
}

protocol ContentProtocol {
    associatedtype RecommendResponse: Decodable, ContentRecommendResponse

    var type: ContentType { get }
    var title: String { get }
    
    // 장르 화면
    func genres() -> Endpoint<GenresResponse>
    
    // 추천작 화면 (제네릭 메서드로 타입 추론)
    func recommend(page: Int) -> Endpoint<RecommendResponse>
}

class Content {
    static let shared = Content()
    private var _content: any ContentProtocol = Movie.shared
    
    private init() {}
    
    var content: any ContentProtocol {
        return _content
    }
   
    func configure(content: any ContentProtocol) {
        if content.type != self.content.type {
            _content = content
        }
    }
}
