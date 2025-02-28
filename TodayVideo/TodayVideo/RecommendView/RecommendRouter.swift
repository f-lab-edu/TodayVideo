//
//  RecommendRouter.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/6/25.
//

import Foundation

protocol RecommendRouterProtocol {
    func pushToDetailView(with id: Int)
}

final class RecommendRouter: RecommendRouterProtocol {
    weak var recommendView: RecommendView?
    
    static func createRecommendViewModule(with genres: [Genre]) -> RecommendView {
        let view = RecommendView(genres: genres)
        let presenter = RecommendPresenter()
        let router = RecommendRouter()
        let interactor = RecommendInteractor()
        
        view.presenter = presenter
        presenter.router = router
        presenter.interator = interactor
        presenter.view = view
        router.recommendView = view
        interactor.presenter = presenter
        
        return view
    }
    
    // RecommendRouterProtocol 함수 채택으로 추가해둠
    func pushToDetailView(with id: Int) {
        let detailView = DetailRouter.createDetailViewModule(with: id)
        recommendView?.navigationController?.pushViewController(detailView, animated: true)
    }
}
