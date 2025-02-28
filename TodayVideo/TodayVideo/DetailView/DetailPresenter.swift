//
//  DetailPresenter.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/27/25.
//

import Foundation

protocol DetailPresenterProtocol {
    func fetchDetail()
    func fetchSuccess(response: Decodable)
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
    
    func fetchSuccess(response: Decodable) {
        view?.makeDetailSuccess()
    }
    
    func fetchFail(_ error: Error) {
        view?.makeDetailFail(error)
    }
}
