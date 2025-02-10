//
//  RecommendInteractor.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/6/25.
//

import Foundation

protocol RecommendInteractorProtocol {
    func fetchRecommend()
}

final class RecommendInteractor: RecommendInteractorProtocol {
    var presenter: RecommendPresenterProtocol?
    
    func fetchRecommend() {
        let content = Content.shared.content
        content.requestRecommends { result in
            //
        }
    }
}
