//
//  RecommendView.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/6/25.
//

import UIKit

protocol RecommendViewProtocol {
    func makeRecommendation(_ movies: [RecommendMovieResponse.Items])
    func makeRecommendation(_ tv: [RecommendTVResponse.Items])
    func makeRecommendation<R: Decodable>(_ response: R)
    func makeRecommendationFail(_ error: Error)
}

class RecommendView: UIViewController {
    var presenter: RecommendPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.fetchRecommend()
    }
}

extension RecommendView: RecommendViewProtocol {
    // RecommendPresenter 에러 방지 위해 프로토콜 채택 처리만 해두었습니다. 추후 작성 예정입니다.
    func makeRecommendation(_ movies: [RecommendMovieResponse.Items]) {
        //
    }
    
    func makeRecommendation(_ tv: [RecommendTVResponse.Items]) {
        //
    }
    
    func makeRecommendation<R>(_ response: R) where R : Decodable {
        //
    }
    
    func makeRecommendationFail(_ error: any Error) {
        //
    }
}
