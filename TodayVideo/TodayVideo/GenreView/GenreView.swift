//
//  GenreView.swift
//  TodayVideo
//
//  Created by 김지나 on 1/27/25.
//

import UIKit
import SnapKit

protocol GenreViewProtocol {
    func makeGenreSuccess(_ genres: [Genre])
    func makeGenreFail(_ error: Error)
}

final class GenreView: UIViewController {
    var presenter: GenrePresenterProtocol?
    var selectedGenre: [Int: Bool] = [:]

    var prevButton: PreviousButton!
    var nextButton: NextButton!
    let scrollView = UIScrollView()
    let scrollViewContainer = UIView()
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
        
        prevButton = PreviousButton(location: self)
        nextButton = NextButton(location: self)
        nextButton.delegate = self
    }
    
    // MARK: - 버튼 기능
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
    
    // 선택한 장르(배열)들을 api 요청 파라미터로 만듦
    private func makeSelectedGenresString(genreIDs: [Int]) -> String {
        guard !genreIDs.isEmpty else {
            return ""
        }
        
        let genreString = genreIDs.map { String($0) }
        
        return genreString.joined(separator: "%2C")
    }
    
    // 선택한 장르(배열)들을 userdefault에 저장
    private func saveSelectedGenre() {
        let genreCount = genreButtons.count
        let genre = (selectedGenre.filter { $0.value == true }).map{ $0.key }
        
        if genreCount == genre.count {
            let genreString = ""
            UserDefault.shared.setValue(genreString, key: .selectGenre)
        } else {
            let genreString = makeSelectedGenresString(genreIDs: genre)
            UserDefault.shared.setValue(genreString, key: .selectGenre)
        }
    }
}

// MARK: - NextButtonDelegate
extension GenreView: NextButtonDelegate {
    func pressed() {
        saveSelectedGenre()
    }
}

// MARK: - GenreViewProtocol
extension GenreView: GenreViewProtocol {
    func makeGenreFail(_ error: Error) {
        DispatchQueue.main.async {
            UIAlertController().fail(error: error, target: self)
        }
    }
    
    func makeGenreSuccess(_ genres: [Genre]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            // 컨테이너
            scrollView.showsVerticalScrollIndicator = false
            scrollView.isScrollEnabled = true
            view.addSubview(scrollView)
            
            // all 버튼
            scrollView.addSubview(allButton)
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
        
        saveSelectedGenre()
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
            
            scrollView.addSubview(button)
            button.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(width)
                make.top.equalToSuperview().offset(height)
                make.width.equalTo(buttonWidth)
                make.height.equalTo(buttonHeight)
            }
            
            width += (buttonWidth + buttonMargin)
        }

        scrollViewConstraints(width: maxContainerWidth, height: height + buttonHeight)
        
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

    private func scrollViewConstraints(width: Int, height: Int) {
        let topMargin: CGFloat = 20
        let bottomMargin: CGFloat = 14
        let top = prevButton.frame.origin.x + prevButton.frame.size.height + topMargin
        let bottom = nextButton.frame.size.height + bottomMargin + self.view.safeAreaInsets.bottom
        let areaHeight = Int(self.view.frame.size.height - top - bottom)

        scrollView.contentSize = CGSize(width: width, height: height)
        
        // 장르 버튼 들을 놓을 수 있는 영역의 높이 > 장르 버튼 들을 놓기위해 필요한 높이
        if areaHeight > height {
            scrollView.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.width.equalTo(width)
                make.height.equalTo(height)
            }
        } else {
            scrollView.snp.makeConstraints { make in
                make.top.equalTo(prevButton.snp.bottom).offset(topMargin)
                make.bottom.equalTo(nextButton.snp.top).offset(-bottomMargin)
                make.width.equalTo(width)
                make.centerX.equalToSuperview()
            }
        }
    }
}
