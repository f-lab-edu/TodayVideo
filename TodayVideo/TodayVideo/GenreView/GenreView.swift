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
    var selectedGenre: [Int: Bool] = [:]

    let containerView = UIView()
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
        
        _ = PreviousButton(location: self)
        _ = NextButton(location: self)
    }
}

// MARK: - GenreViewProtocol
extension GenreView: GenreViewProtocol {
    func makeGenreButton(_ genres: [Genre]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            // 컨테이너
            view.addSubview(containerView)
            
            // all 버튼
            containerView.addSubview(allButton)
            makeAllButton()
            
            // 장르 버튼
            createGenreButtons(genres)
        }
    }
    
    private func makeAllButton() {
        allButton.tag = -1
        allButton.isSelected = true
        allButton.updateState()
        allButton.addTarget(self, action: #selector(allGenreSelect), for: .touchUpInside)
        
        allButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo(allButton.width())
            make.height.equalTo(allButton.height)
        }
    }
    
    private func createGenreButtons(_ genres: [Genre]) {
        let containerLeftRightMargin: CGFloat = 68
        let maxContainerWidth = Int(self.view.frame.size.width - containerLeftRightMargin)
        let buttonMargin = 6
        let buttonHeight = Int(allButton.height)
        var height = buttonHeight + buttonMargin
        var width = 0
        
        for genre in genres {
            guard let title = genre.name,
                  let id = genre.id else { continue }
            let button = createButton(title: title, id: id)
            let buttonWidth = Int(button.width())
            
            // 버튼이 들어갈 자리가 충분한지 확인
            if (maxContainerWidth - width) < (buttonWidth + buttonMargin) {
                width = 0
                height += buttonHeight + buttonMargin
            }
            
            containerView.addSubview(button)
            button.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(width)
                make.top.equalToSuperview().offset(height)
                make.width.equalTo(buttonWidth)
                make.height.equalTo(buttonHeight)
            }
            
            width += (buttonWidth + buttonMargin)
        }

        containerViewConstraints(width: maxContainerWidth, height: height + buttonHeight)
    }

    private func createButton(title: String, id: Int) -> FilterButton {
        let button = FilterButton(title: title)
        button.tag = id
        button.isSelected = false
        button.updateState()
        button.addTarget(self, action: #selector(genreSelect(_:)), for: .touchUpInside)
        
        genreButtons.append(button)
        selectedGenre[id] = true
        return button
    }

    private func containerViewConstraints(width: Int, height: Int) {
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    
    func makeGenreFail(_ error: Error) {
        let alert = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default) { action in
            alert.dismiss(animated: true)
        }
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    private func controlAllButton(_ select: Bool) {
        allButton.isSelected = select
        allButton.updateState()
        
        selectedGenre.forEach { key, value in
            selectedGenre[key] = select
        }
    }
    
    @objc private func allGenreSelect() {
        controlAllButton(!allButton.isSelected)
        
        let selectFilter = selectedGenre.filter{$0.value == true}
        if !selectFilter.isEmpty {
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
        if selectFilter.isEmpty {
            controlAllButton(true)
        }
    }
}
