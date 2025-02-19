//
//  NextButton.swift
//  TodayVideo
//
//  Created by iOS Dev on 1/16/25.
//

import UIKit
import SnapKit

protocol NextButtonDelegate {
    func pressed()
}

final class NextButton: UIButton {
    private var currentView: UIViewController!
    var delegate: NextButtonDelegate?
    
    init(location: UIViewController) {
        super.init(frame: .zero)
        
        self.currentView = location
        self.setImage(.nextButton, for: .normal)
        self.addTarget(self, action: #selector(pushToNextView), for: .touchUpInside)
        self.currentView.view.addSubview(self)
        self.layout(in: currentView.view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout(in view: UIView) {
        self.snp.makeConstraints { make in
            make.width.equalTo(15.4)
            make.height.equalTo(23)
            make.trailing.equalTo(view.snp.trailing).offset(-41.6)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-27.27)
        }
    }
    
    @objc private func pushToNextView() {
        switch currentView {
        case is ContentView:
            guard let contentView = currentView as? ContentView else { return }
            contentView.presenter?.pushToGenreView()
        case is GenreView:
            guard let genreView = currentView as? GenreView else { return }
            genreView.presenter?.pushToRecommendView()
            delegate?.pressed()
        default: break
        }
    }
}
