//
//  DetailInteractor.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/27/25.
//

import Foundation

protocol DeailInteractorProtocol {
    func fetchDetail(with id: Int)
}
final class DetailInteractor: DeailInteractorProtocol {
    var presenter: DetailPresenterProtocol?
    
    func fetchDetail(with id: Int) {
        let content = Content.shared.content
        
        if let tv = content as? TV {
            fetchDetail(tv, id: id)
        } else if let movie = content as? Movie {
            fetchDetail(movie, id: id)
        }
    }
    
    func fetchDetail<T: ContentProtocol>(_ content: T, id: Int) {
        let detailEndpoint = content.detail(id: id)
        let videoEndpoint = content.video(id: id)
        
        Task {
            do {
                let detail = try await requestDetail(detailEndpoint)
                let video = try await requestDetail(videoEndpoint)
                self.presenter?.fetchDetailSuccess(response: detail, video: video)
            } catch let error {
                self.presenter?.fetchFail(error)
            }
        }
    }
    
    func requestDetail<T: Decodable>(_ endpoint: Endpoint<T>) async throws -> Endpoint<T>.Response {
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
