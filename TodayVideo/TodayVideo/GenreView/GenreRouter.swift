//
//  GenreRouter.swift
//  TodayVideo
//
//  Created by 김지나 on 1/27/25.
//

import Foundation

protocol GenreRouterProtocol {
    func pushToRecommendView()
}

final class GenreRouter: GenreRouterProtocol {
    weak var genreView: GenreView?
    
    static func createGenreViewModule() -> GenreView {
        let view = GenreView()
        let presenter = GenrePresenter()
        let router = GenreRouter()
        let interactor = GenreInteractor()
        
        view.presenter = presenter
        presenter.router = router
        presenter.interator = interactor
        presenter.view = view
        router.genreView = view
        interactor.presenter = presenter
        
        return view
    }
    
    func pushToRecommendView() {
        // 다음 화면으로 이동을 위한 처리 코드 입니다.
//        let recommendView = RecommendRouter.createRecommendViewModule
//        genreView?.navigationController?.pushViewController(recommendView, animated: true)
    }
}
