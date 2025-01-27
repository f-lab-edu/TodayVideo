//
//  GenreView.swift
//  TodayVideo
//
//  Created by 김지나 on 1/27/25.
//

import UIKit
import SnapKit

protocol GenreViewProtocol {
    func makeGenreButton(_ genres: [Genre])
    func makeGenreFail(_ error: Error)
}

final class GenreView: UIViewController {
    var presenter: GenrePresenterProtocol?
    var selectedGenre: [Int:Bool] = [:]

    let allButton = FilterButton(title: "무관")
    var genreButtons = [FilterButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawUI()
        presenter?.fetchGenres()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      navigationController?.isNavigationBarHidden = true
    }
    
    private func drawUI() {
        view.backgroundColor = .background
        
        let _ = PreviousButton(location: self)
        let _ = NextButton(location: self)
    }
}



extension GenreView: GenreViewProtocol {
    func makeGenreButton(_ genres: [Genre]) {
        DispatchQueue.main.async { [self] in
            
            // 컨테이너
            let containerView = UIView()
            let containerLeftRightMargin: CGFloat = 68
            let maxContainerWidth = Int(self.view.frame.size.width - containerLeftRightMargin)
            self.view.addSubview(containerView)
            
            // all 버튼
            allButton.tag = -1
            allButton.isSelected = true
            allButton.updateState()
            allButton.addTarget(self, action: #selector(allGenreSelect), for: .touchUpInside)
            containerView.addSubview(allButton)
            allButton.snp.makeConstraints { make in
                make.leading.equalToSuperview()
                make.top.equalToSuperview()
                make.width.equalTo(allButton.width())
                make.height.equalTo(allButton.height)
            }
            
            // 장르 버튼
            let buttonMargin: Int = 6
            var height: Int = Int(allButton.height) + buttonMargin
            var width: Int = 0
            var buttonWidth: Int = 0
            var buttonHeight: Int = 0
            
            for idx in 0 ..< genres.count {
                if let title = genres[idx].name, let id = genres[idx].id {
                    let button = FilterButton(title: title)
                    buttonWidth = Int(button.width())
                    buttonHeight = Int(button.height)
                    
                    button.tag = id
                    button.isSelected = false
                    button.updateState()
                    button.addTarget(self, action: #selector(genreSelect(_:)), for: .touchUpInside)
                    self.genreButtons.append(button)
                    self.selectedGenre.updateValue(true, forKey: id)
                    containerView.addSubview(button)
                    
                    // 버튼이 들어갈 자리가 충분한지 확인
                    if (maxContainerWidth - width) < (buttonWidth + buttonMargin) {
                        width = 0
                        height += buttonHeight + buttonMargin
                    }
                                        
                    button.snp.makeConstraints { make in
                        make.leading.equalToSuperview().offset(width)
                        make.top.equalToSuperview().offset(height)
                        make.width.equalTo(buttonWidth)
                        make.height.equalTo(buttonHeight)
                    }
                    
                    width += (buttonWidth + buttonMargin)
                }
            }
            
            containerView.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.width.equalTo(maxContainerWidth)
                make.height.equalTo(height + buttonHeight)
            }
        }
    }
    
    func makeGenreFail(_ error: Error) {
        let alert = UIAlertController(title: "", message: "일시적인 오류가 발생하였습니다.\n나중에 다시 시도해주세요.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default){ action in
            alert.dismiss(animated: true)
            }
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    private func controlAllButton(_ select: Bool) {
        allButton.isSelected = select
        allButton.updateState()
        
        selectedGenre.forEach { key,value in
            selectedGenre[key] = select
        }
    }
    
    @objc private func allGenreSelect() {
        controlAllButton(!allButton.isSelected)
        
        let selectFilter = selectedGenre.filter{$0.value == true}
        if selectFilter.count > 0 {
            genreButtons.forEach { button in
                button.isSelected = false
                button.updateState()
            }
        }
    }
    
    @objc private func genreSelect(_ sender: FilterButton) {
        sender.isSelected = !sender.isSelected
        sender.updateState()
        
        if allButton.isSelected {
            controlAllButton(false)
        }
        
        let id = sender.tag
        selectedGenre[id] = sender.isSelected
        
        let selectFilter = selectedGenre.filter{$0.value == true}
        if selectFilter.count == 0 {
            controlAllButton(true)
        }
    }
}
