//
//  ContentView.swift
//  TodayVideo
//
//  Created by iOS Dev on 1/15/25.
//

import UIKit
import SnapKit

enum Content: String {
    case movie = "영화"
    case tv = "TV"
}

final class ContentView: UIViewController {
    var presenter: ContentPresenterProtocol?
    
    private var movieButton: FilterButton!
    private var tvButton: FilterButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawUI()
        buttonSelected(movieButton)
    }
    
    private func drawUI() {
        self.view.backgroundColor = .background
        
        // 영화, 드라마 버튼
        /// 컨테이너
        let height: CGFloat = 50.0
        let containerView = UIView()
        let containerViewWidth: CGFloat = 300.0
        
        self.view.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(height)
            make.width.equalTo(containerViewWidth)
        }
        
        /// 버튼
        movieButton = FilterButton(title: Content.movie.rawValue)
        tvButton = FilterButton(title: Content.tv.rawValue)
        
        [movieButton, tvButton].forEach { button in
            button.addTarget(self, action: #selector(buttonSelected(_:)), for: .touchUpInside)
            containerView.addSubview(button)
        }
        
        let margin: CGFloat = 8.0
        let buttonWidth = (containerViewWidth / 2) - margin
        
        movieButton.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(buttonWidth)
        }
        
        tvButton.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.width.equalTo(buttonWidth)
        }
        
        // 다음 버튼
        let _ = NextButton(location: self)
    }
    
    @objc private func buttonSelected(_ sender: UIButton) {
        // 이미 선택되어 있는 버튼이면 return
        if sender.isSelected {
            return
        }
        
        sender.isSelected = !sender.isSelected
        
        DispatchQueue.main.async {
            if sender == self.movieButton {
                UserDefaults.standard.setValue(Content.movie.rawValue, forKey: UserdefaultKey.selectContent.rawValue)
                self.tvButton.isSelected = false
                self.tvButton.updateState()
                self.movieButton.updateState()
            } else {
                UserDefaults.standard.setValue(Content.tv.rawValue, forKey: UserdefaultKey.selectContent.rawValue)
                self.movieButton.isSelected = false
                self.movieButton.updateState()
                self.tvButton.updateState()
            }
        }
    }
}
