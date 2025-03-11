//
//  RecommendInteractor.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/6/25.
//

import Foundation

protocol RecommendInteractorProtocol {
    func fetchRecommend()
}

final class RecommendInteractor: RecommendInteractorProtocol {
    var presenter: RecommendPresenterProtocol?
    
    func fetchRecommend() {
        let content = Content.shared.content
        fetchRandomRecommend(content)
    }
    
    func fetchRandomRecommend(_ content: any ContentProtocol) {
        let firstPage = 1
        
        func fetchRecommendation<T: ContentProtocol>(_ content: T) {
            let endpoint = content.recommend(page: firstPage)
            
            Task {
                do {
                    let firstResponse = try await requestRecommendTotalPage(endpoint: endpoint)
                    let endpoint = content.recommend(page: firstResponse.totalPages)
                    let finalResponse = try await requestRecommendTotalPage(endpoint: endpoint)
                    self.presenter?.fetchSuccess(response: finalResponse.results)
                } catch let error {
                    self.presenter?.fetchFail(with: error)
                }
            }
        }
        
        if let tv = content as? TV {
            fetchRecommendation(tv)
        } else if let movie = content as? Movie {
            fetchRecommendation(movie)
        }
    }
    
    func requestRecommendTotalPage<T: Decodable>(endpoint: Endpoint<T>) async throws -> Endpoint<T>.Response {
        return try await withCheckedThrowingContinuation { continuation in
            Network.shared.request(with: endpoint) { result in
                switch result {
                case .success(let response):
                    continuation.resume(returning: response)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
