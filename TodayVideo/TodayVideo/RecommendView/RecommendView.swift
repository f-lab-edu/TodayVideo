//
//  RecommendView.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/6/25.
//

import UIKit
import SnapKit

protocol RecommendViewProtocol {
    func makeRecommendation<T: Decodable>(_ response: [T])
    func makeRecommendationFail(_ error: Error)
}

class RecommendView: UIViewController {
    var presenter: RecommendPresenterProtocol?
    var genres = [Genre]()
    var items: [RecommendItem] = []
    
    let indicator = UIActivityIndicatorView(style: .large)
    var previousButton: PreviousButton!
    let cardCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    init(genres: [Genre]) {
        self.genres = genres
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ui
        view.backgroundColor = .background
        previousButton = PreviousButton(location: self)
        makeIndicator()
        
        // api
        presenter?.fetchRecommend()
    }
    
    func makeIndicator() {
        view.addSubview(indicator)
        
        indicator.center = view.center
        indicator.color = .buttonSelectedBackground
        indicator.startAnimating()
    }
    
    // MARK: - background
    private func drawBackground() {
        backgroundDesign()
    }
    
    // top blue circle
    private func backgroundDesign() {
        // circle
        let rate = 2.4
        let height = self.view.frame.size.height / rate
        let radius = height / 2
        let blueHalfCircle = UIView()
        
        blueHalfCircle.backgroundColor = .buttonSelectedBackground
        blueHalfCircle.roundCorners(cornerRadius: radius, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        
        self.view.addSubview(blueHalfCircle)
        blueHalfCircle.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(height)
        }
        
        // film image
        let filmImageView = UIImageView()
        filmImageView.image = .filmBackground
        filmImageView.tintColor = .black.withAlphaComponent(0.2)
   
        blueHalfCircle.addSubview(filmImageView)
        filmImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - video card
    private func drawVideoCard() {
        card()
    }
    
    private func card() {
        let rate = 1.3
        let height = self.view.frame.size.height / rate
        let topMargin = 20
        
        cardCollectionView.register(RecommendCell.self, forCellWithReuseIdentifier: RecommendCell.identifier)
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self
        cardCollectionView.decelerationRate = .fast
        cardCollectionView.isPagingEnabled = true
        cardCollectionView.backgroundColor = .clear
        self.view.addSubview(cardCollectionView)
        
        cardCollectionView.snp.makeConstraints { make in
            make.top.equalTo(previousButton.snp.bottom).offset(topMargin)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(height)
        }
    }
}

// MARK: - RecommendViewProtocol
extension RecommendView: RecommendViewProtocol {
    func makeRecommendation<T>(_ response: [T]) where T: Decodable {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            if let tv = response as? [RecommendTVResponse.Items] {
                self.items = tv
            } else if let movie = response as? [RecommendMovieResponse.Items] {
                self.items = movie
            }
            
            self.drawBackground()
            self.drawVideoCard()
            self.cardCollectionView.reloadData()
            self.indicator.stopAnimating()
            self.view.bringSubviewToFront(previousButton)
        }
    }
    
    func makeRecommendationFail(_ error: any Error) {
        DispatchQueue.main.async {
            UIAlertController().fail(error: error, target: self)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension RecommendView: UICollectionViewDataSource {    
    private func genreName(by ids: [Int]) -> String {
        var result = ""
        
        for genre in genres {
            guard let id = genre.id else { return "" }
            guard let name = genre.name else { return "" }
            
            if ids.contains(id) {
                result += "\(name),"
            }
        }
        
        result = String(result.dropLast(1))
        result = result.replacingOccurrences(of: ",", with: " ・ ")
        
        return result
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCell.identifier, for: indexPath)
                as? RecommendCell else { return UICollectionViewCell() }
        
        if let tv = items as? [RecommendTVResponse.Items] {
            let item = tv[indexPath.item]
            let genreName = genreName(by: item.genreIds)
            cell.configTVCell(with: item, genreName)
        } else if let movie = items as? [RecommendMovieResponse.Items] {
            let item = movie[indexPath.item]
            let genreName = genreName(by: item.genreIds)
            cell.configMovieCell(with: item, genreName)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        if let tv = items as? [RecommendTVResponse.Items] {
            let id = tv[index].id
            presenter?.pushToDetailView(with: id)
        } else if let movie = items as? [RecommendMovieResponse.Items] {
            let id = movie[index].id
            presenter?.pushToDetailView(with: id)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RecommendView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: collectionView.frame.size.height)
    }
}
