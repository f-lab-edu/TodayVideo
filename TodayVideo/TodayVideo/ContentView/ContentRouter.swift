//
//  ContentRouter.swift
//  TodayVideo
//
//  Created by iOS Dev on 1/15/25.
//

import UIKit

protocol ContentRouterProtocol {
    func pushToGenreView()
}

final class ContentRouter: ContentRouterProtocol {
    weak var contentView: ContentView?
    
    static func createContentViewModule() -> ContentView {
        let view = ContentView()
        let presenter = ContentPresenter()
        let router = ContentRouter()
        
        view.presenter = presenter
        presenter.router = router
        router.contentView = view
        
        return view
    }
    
    // 장르 선택 화면으로 push
    func pushToGenreView() {
//        let genreView = GenreRouter.createGenre
//        contentView?.navigationController?.pushViewController(genreView, animated: true)
    }
}
