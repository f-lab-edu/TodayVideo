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
        let selectedContent = UserDefault.shared.stringForKey(.selectContent)
        if selectedContent == Content.tv.rawValue {
            return APIEndpoint.getTVGenres()
        } else {
            return APIEndpoint.getMovieGenres()
        }
    }
    
    func fetchGenres() {
        let endpoint = endpoint()
        
        Network().request(with: endpoint) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.presenter?.fetchSuccess(with: response.genres)
            case .failure(let error):
                self.presenter?.fetchFail(with: error)
            }
        }
    }
    
    private func resultProcess(_ result: Result<GenresResponse, Error>) {
        switch result {
        case .success(let response):
            presenter?.fetchSuccess(with: response.genres)
        case .failure(let error):
            presenter?.fetchFail(with: error)
        }
    }
}
