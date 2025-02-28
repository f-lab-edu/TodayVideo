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
        func fetchDetail<T: ContentProtocol>(_ content: T) {
            
        }
        
        if let tv = content as? TV {
            let endpoint = APIEndpoint.shared.getTVDetail(with: id)
            requestDetail(endpoint)
        } else if let movie = content as? Movie {
            let endpoint = APIEndpoint.shared.getMovieDetail(with: id)
            requestDetail(endpoint)
        }
    }
    
    func requestDetail<T: Decodable>(_ endpoint: Endpoint<T>) {
        Network.shared.request(with: endpoint) { result in
            switch result {
            case .success(let response):
                self.presenter?.fetchSuccess(response: response)
            case .failure(let error):
                self.presenter?.fetchFail(error)
            }
        }
    }
    
    func requestVideo() {
//        Network.shared.request(with: <#T##RequesteResponsable#>, completion: <#T##(Result<Decodable, any Error>) -> Void#>)
    }
}
