//
//  Presenter.swift
//  TodayVideo
//
//  Created by iOS Dev on 12/30/24.
//

import UIKit

protocol SplashPresenterProtocol {
    func pushToContentsView()
}

final class SplashPresenter: SplashPresenterProtocol {
    var router: SplashRouterProtocol?
    
    func pushToContentsView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.router?.pushToContentsView()
        }
    }
}
