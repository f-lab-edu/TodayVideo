//
//  NextButton.swift
//  TodayVideo
//
//  Created by iOS Dev on 1/16/25.
//

import UIKit
import SnapKit

final class NextButton: UIButton {
    private var currentView: UIViewController!
    
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
            make.bottom.equalTo(view.snp.bottom).offset(-78)
        }
    }
    
    @objc private func pushToNextView() {
        switch currentView {
        case is ContentView:
            guard let contentView = currentView as? ContentView else { return }
            contentView.presenter?.pushToGenreView()
        default: 
            break
        }
    }
}
