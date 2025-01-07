//
//  Presenter.swift
//  TodayVideo
//
//  Created by iOS Dev on 12/30/24.
//

import Foundation

protocol SplashPresenterProtocol {
    func showMain()
}

final class SplashPresenter: SplashPresenterProtocol {
    let router: SplashRouterProtocol!

    init(router: SplashRouterProtocol) {
        self.router = router
    }
    
    func showMain() {
        router.showMain()
    }
}
