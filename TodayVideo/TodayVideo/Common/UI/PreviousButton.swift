//
//  PreviousButton.swift
//  TodayVideo
//
//  Created by 김지나 on 1/27/25.
//

import Foundation
import SnapKit

final class PreviousButton: UIButton {
    private var currentView: UIViewController!
    
    init(location: UIViewController) {
        super.init(frame: .zero)
        
        self.currentView = location
        self.setImage(.previousButton, for: .normal)
        self.addTarget(self, action: #selector(popToPreviousView), for: .touchUpInside)
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
            make.leading.equalTo(view.snp.leading).offset(41.6)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(27.27)
        }
    }
    
    @objc private func popToPreviousView() {
        currentView.navigationController?.popViewController(animated: true)
    }
}
