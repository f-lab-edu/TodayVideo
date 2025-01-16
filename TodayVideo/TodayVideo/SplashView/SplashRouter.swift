//
//  Router.swift
//  TodayVideo
//
//  Created by iOS Dev on 12/30/24.
//

import UIKit

protocol SplashRouterProtocol {
    func pushToContentsView()
}

final class SplashRouter: SplashRouterProtocol {
    weak var splashView: SplashView?
    
    static func createSplashViewModule() -> SplashView {
        let view = SplashView()
        var presenter = SplashPresenter()
        let router = SplashRouter()
        
        view.presenter = presenter
        presenter.router = router
        router.splashView = view
        
        return view
    }
    
    // 영화, 드라마 선택화면으로 push
    func pushToContentsView() {
        let contentView = ContentRouter.createContentViewModule()
        splashView?.navigationController?.setViewControllers([contentView], animated: true)
    }
}
