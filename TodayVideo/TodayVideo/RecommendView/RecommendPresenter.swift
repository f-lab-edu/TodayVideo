//
//  RecommendPresenter.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/6/25.
//

import Foundation

protocol RecommendPresenterProtocol {
    func fetchRecommend()
    func fetchSuccess<R: Decodable>(response: R)
    func fetchFail(with error: Error)
    func pushToDetailView()
}

final class RecommendPresenter: RecommendPresenterProtocol {
    var view: RecommendViewProtocol?
    var interator: RecommendInteractorProtocol?
    var router: RecommendRouterProtocol?
    
    func fetchRecommend() {
        interator?.fetchRecommend()
    }
    
    func fetchSuccess<R: Decodable>(response: R) {
        view?.makeRecommendation(response)
    }

    func fetchFail(with error: Error) {
        view?.makeRecommendationFail(error)
    }
    
    func pushToDetailView() {
        DispatchQueue.main.async {
            self.router?.pushToRecommendView()
        }
    }
}
