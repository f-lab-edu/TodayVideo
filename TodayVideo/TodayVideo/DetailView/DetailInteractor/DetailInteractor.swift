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
        fetchDetail(content, id: id)
    }
    
    func fetchDetail(_ content: any ContentProtocol, id: Int) {
        if let _ = content as? TV {
            let detailEndpoint = APIEndpoint.shared.getTVDetail(with: id)
            let videoEndpoint = APIEndpoint.shared.getTvVideo(with: id)
            requestDetail(detailEndpoint)
            requestDetail(videoEndpoint, isRequestVideo: true)
        } else if let _ = content as? Movie {
            let detailEndpoint = APIEndpoint.shared.getMovieDetail(with: id)
            let videoEndpoint = APIEndpoint.shared.getMovieVideo(with: id)
            requestDetail(detailEndpoint)
            requestDetail(videoEndpoint, isRequestVideo: true)
        }
    }
    
    func requestDetail<T: Decodable>(_ endpoint: Endpoint<T>, isRequestVideo: Bool? = nil) {
        Network.shared.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                if isRequestVideo != nil && isRequestVideo! {
                    self.presenter?.fetchVideoSuccess(response: response as! DetailContentVideo)
                } else {
                    self.presenter?.fetchDetailSuccess(response: response)
                }
                
            case .failure(let error):
                self.presenter?.fetchFail(error)
            }
        }
    }
}
