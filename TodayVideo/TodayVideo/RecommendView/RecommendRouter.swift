//
//  RecommendRouter.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/6/25.
//

import Foundation

protocol RecommendRouterProtocol {
    func pushToRecommendView()
}

final class RecommendRouter: RecommendRouterProtocol {
    weak var recommendView: RecommendView?
    
    static func createRecommendViewModule() -> RecommendView {
        let view = RecommendView()
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
    
    func pushToRecommendView() {
        // 다음 화면으로 이동을 위한 처리 코드 입니다.
//        let recommendView = RecommendRouter.createRecommendViewModule
//        genreView?.navigationController?.pushViewController(recommendView, animated: true)
    }
}
