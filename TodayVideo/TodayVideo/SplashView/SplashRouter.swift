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
        
        return view
    }
    
    func pushToContentsView() {
        // 영화, 드라마 선택화면으로 push
        splashView?.navigationController?.setViewControllers([UIViewController()], animated: true)
    }
}
