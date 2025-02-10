//
//  Content.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/11/25.
//

import Foundation

protocol SelectedContent {
    var title: String { get }
    // 장르 화면
    func genres() -> Endpoint<GenresResponse>
    func requestGenre(endpoint: Endpoint<GenresResponse>, completion: @escaping (Result<[Genre], Error>)->())
    // 추천작 화면
    func recommendRequest(by page: Int) -> RecommendRequest
    func recommends<T: Decodable, R: Endpoint<T>>(page: Int) -> R
    func requestTotalPage(completion:@escaping (Int) -> Void)
    func requestRecommends<T: Decodable>(completion: @escaping (Result<[T], Error>) -> Void)
    
}
extension SelectedContent {
    func requestGenre(endpoint: Endpoint<GenresResponse>, completion: @escaping (Result<[Genre], Error>)->()) {
        Network.shared.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                completion(.success(response.genres))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func recommendRequest(by page: Int) -> RecommendRequest {
        let page = Int.random(in: 1 ... page)
        let genre = UserDefault.shared.stringForKey(.selectGenre) ?? ""
        
        return RecommendRequest(page: Int32(page), withGenres: genre)
    }
}

// MARK: - Content class
class Movie: SelectedContent {
    let title: String = "영화"
    
    func genres() -> Endpoint<GenresResponse> {
        return APIEndpoint.shared.getMovieGenres()
    }
    
    func recommends<T, R>(page: Int) -> R where T : Decodable, R : Endpoint<T> {
        let request = recommendRequest(by: page)
        return APIEndpoint.shared.getMovieDiscover(with: request) as! R
    }
    
    func requestTotalPage(completion:@escaping (Int) -> Void) {
        guard let endpoint = self.recommends(page: 1) as? Endpoint<RecommendMovieResponse> else { return }
        
        Network.shared.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                completion(response.totalPages)
            case .failure:
                completion(1)
            }
        }
    }
    
    func requestRecommends<T>(completion: @escaping (Result<[T], any Error>) -> Void) where T : Decodable {
        requestTotalPage() { totalPage in
            guard let endpoint = self.recommends(page: totalPage) as? Endpoint<RecommendMovieResponse> else { return }
            
            Network.shared.request(with: endpoint) { result in
                switch result {
                case .success(let response):
                    guard let response = response.results as? [T] else { return }
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func items() -> Result<[RecommendMovieResponse.Items], Error> {
        
    }
}

class TV: SelectedContent {
    let title: String = "드라마"
    
    func genres() -> Endpoint<GenresResponse> {
        return APIEndpoint.shared.getTVGenres()
    }
    
    func recommends<T, R>(page: Int) -> R where T : Decodable, R : Endpoint<T> {
        let request = recommendRequest(by: page)
        return APIEndpoint.shared.getTVDiscover(with: request) as! R
    }
    
    func requestTotalPage(completion:@escaping (Int) -> Void) {
        guard let endpoint = self.recommends(page: 1) as? Endpoint<RecommendTVResponse> else { return }
        
        Network.shared.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                completion(response.totalPages)
            case .failure:
                completion(1)
            }
        }
    }
    
    func requestRecommends<T>(completion: @escaping (Result<[T], any Error>) -> Void) where T : Decodable {
        requestTotalPage() { totalPage in
            guard let endpoint = self.recommends(page: totalPage) as? Endpoint<RecommendTVResponse> else { return }
            
            Network.shared.request(with: endpoint) { result in
                switch result {
                case .success(let response):
                    guard let response = response.results as? [T] else { return }
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}

class Content {
    static let shared = Content()
    
    private var isConfigured = false
    private var _content: SelectedContent = Movie()
    
    private init() {}
    
    var content: SelectedContent {
        return _content
    }
    
    func configure(content: SelectedContent) {
        if content.title != self.content.title {
            _content = content
        }
    }
}
