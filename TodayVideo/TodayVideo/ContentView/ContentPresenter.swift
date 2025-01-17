//
//  ContentPresenter.swift
//  TodayVideo
//
//  Created by iOS Dev on 1/15/25.
//

import Foundation

protocol ContentPresenterProtocol {
    func pushToGenreView()
}

final class ContentPresenter: ContentPresenterProtocol {
    var router: ContentRouterProtocol?
    
    func pushToGenreView() {
        DispatchQueue.main.async {
            self.router?.pushToGenreView()
        }
    }
}
