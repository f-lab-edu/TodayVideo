//
//  GenrePresenter.swift
//  TodayVideo
//
//  Created by 김지나 on 1/27/25.
//

import Foundation

protocol GenrePresenterProtocol {
    func fetchGenres()
    func fetchSuccess(with genres: [Genre])
    func fetchFail(with error: Error)
    func pushToRecommendView()
}

final class GenrePresenter: GenrePresenterProtocol {
    var view: GenreViewProtocol?
    var interator: GenreInteractorProtocol?
    var router: GenreRouterProtocol?
    
    func fetchGenres() {
        interator?.fetchGenres()
    }
    
    func fetchSuccess(with genres: [Genre]) {
        view?.makeGenreSuccess(genres)
    }
    
    func fetchFail(with error: Error) {
        view?.makeGenreFail(error)
    }
    
    func pushToRecommendView() {
        DispatchQueue.main.async {
            self.router?.pushToRecommendView()
        }
    }
}
