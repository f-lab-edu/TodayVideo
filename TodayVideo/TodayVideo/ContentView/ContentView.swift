//
//  ContentView.swift
//  TodayVideo
//
//  Created by iOS Dev on 1/15/25.
//

import UIKit
import SnapKit

//enum Content: String {
//    case movie = "영화"
//    case tv = "TV"
//}

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
        movieButton = FilterButton(title: Movie().title)
        tvButton = FilterButton(title: TV().title)
        
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
    
    func selectEvent(button1: FilterButton, button2: FilterButton) {
        button1.isSelected = false
        button1.updateState()
        button2.updateState()
    }
    
    @objc private func buttonSelected(_ sender: UIButton) {
        // 이미 선택되어 있는 버튼이면 return
        if sender.isSelected {
            return
        }
        
        sender.isSelected = !sender.isSelected
        
        DispatchQueue.main.async {
            let content = Content.shared
            
            if sender == self.movieButton {
                let movie = Movie()
                content.configure(content: movie)
                self.selectEvent(button1: self.tvButton, button2: self.movieButton)
            } else {
                let tv = TV()
                content.configure(content: tv)
                self.selectEvent(button1: self.movieButton, button2: self.tvButton)
            }
        }
    }
}
