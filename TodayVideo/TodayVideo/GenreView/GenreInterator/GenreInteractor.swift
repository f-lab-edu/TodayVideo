//
//  GenreInteractor.swift
//  TodayVideo
//
//  Created by 김지나 on 1/19/25.
//

import Foundation

protocol GenreInteractorProtocol {
    func fetchGenres()
}

final class GenreInteractor: GenreInteractorProtocol {
    var presenter: GenrePresenterProtocol?
    
    func endpoint() -> Endpoint<GenresResponse> {
        let content = Content.shared.content
        return content.genres()
    }
    
    func fetchGenres() {
        let endpoint = endpoint()
        
        Network.shared.request(with: endpoint) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.presenter?.fetchSuccess(with: response.genres)
            case .failure(let error):
                self.presenter?.fetchFail(with: error)
            }
        }
    }
}
