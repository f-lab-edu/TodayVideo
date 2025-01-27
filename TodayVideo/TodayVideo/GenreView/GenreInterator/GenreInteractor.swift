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

class GenreInteractor: GenreInteractorProtocol {
    var presenter: GenrePresenterProtocol?
    
    func fetchGenres() {
        Network().requestGenres() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let genre):
                self.presenter?.fetchSuccess(with: genre)
            case .failure(let error):
                self.presenter?.fetchFail(with: error)
            }
        }
    }
}
