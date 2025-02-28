//
//  DetailRouter.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/27/25.
//

import Foundation

final class DetailRouter {
    weak var detailView: DetailView?
    
    static func createDetailViewModule(with id: Int) -> DetailView {
        let view = DetailView()
        let presenter = DetailPresenter(id: id)
        let interactor = DetailInteractor()
        
        view.presenter = presenter
        presenter.interator = interactor
        presenter.view = view
        interactor.presenter = presenter
        
        return view
    }
}
