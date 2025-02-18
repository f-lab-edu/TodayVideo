//
//  RecommendPresenter.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/6/25.
//

import Foundation

protocol RecommendPresenterProtocol {
    func fetchRecommend()
    func fetchSuccess(response: [RecommendItems])
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
    
    func fetchSuccess(response: [RecommendItems]) {
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
