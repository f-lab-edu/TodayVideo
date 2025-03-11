//
//  DetailPresenter.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/27/25.
//

import Foundation

protocol DetailPresenterProtocol {
    func fetchDetail()
    func fetchDetailSuccess(response: Decodable, video: DetailContentVideo)
    func fetchFail(_ error: Error)
}

final class DetailPresenter: DetailPresenterProtocol {
    var view: DetailViewProtocol?
    var interator: DeailInteractorProtocol?
    var id: Int?
    
    init(id: Int) {
        self.id = id
    }
    
    func fetchDetail() {
        guard let id = id else {
            view?.makeDetailFail(NetworkError.emptyData)
            return
        }
        
        interator?.fetchDetail(with: id)
    }
    
    func fetchDetailSuccess(response: Decodable, video: DetailContentVideo) {
        view?.makeDetailSuccess(response: response, video: video)
    }
    
    func fetchFail(_ error: Error) {
        view?.makeDetailFail(error)
    }
}
