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
    
    func fetchGenres() {
        let content = Content.shared.content
        let endpoint = content.genres()
        
        content.requestGenre(endpoint: endpoint) { result in
            switch result {
            case .success(let genres):
                self.presenter?.fetchSuccess(with: genres)
            case .failure(let error):
                self.presenter?.fetchFail(with: error)
            }
        }
    }
}
