//
//  DetailView.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/27/25.
//

import UIKit

protocol DetailViewProtocol {
    func makeDetailSuccess()
    func makeDetailFail(_ error: Error)
}

final class DetailView: UIViewController {
    var presenter: DetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.fetchDetail()
    }
}

extension DetailView: DetailViewProtocol {
    func makeDetailSuccess() {
        //
    }
    
    func makeDetailFail(_ error: any Error) {
        DispatchQueue.main.async {
            UIAlertController().fail(error: error, target: self)
        }
    }
}
