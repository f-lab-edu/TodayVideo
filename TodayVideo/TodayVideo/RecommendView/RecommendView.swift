//
//  RecommendView.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/6/25.
//

import UIKit
import SnapKit

protocol RecommendViewProtocol {
    func makeRecommendation(_ response: [RecommendItems])
    func makeRecommendationFail(_ error: Error)
}

class RecommendView: UIViewController {
    var presenter: RecommendPresenterProtocol?
    var items: [RecommendItems] = []
    
    var previousButton: PreviousButton!
    let cardCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 20
        
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        drawUI()
        presenter?.fetchRecommend()
    }
    
    private func drawUI() {
        drawBackground()
        
        previousButton = PreviousButton(location: self)
        
        // recommend video card
        drawVideoCard()
    }
    
    // MARK: - background
    private func drawBackground() {
        // background color
        view.backgroundColor = .background
        
        // top blue circle
        background()
    }
    
    private func background() {
        // circle
        let rate = 2.4
        let height = self.view.frame.size.height / rate
        let blueHalfCircle = UIView()
        
        blueHalfCircle.backgroundColor = .buttonSelectedBackground
        blueHalfCircle.roundCorners(cornerRadius: height / 2, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        
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
        cardCollectionView.dataSource = self
        cardCollectionView.backgroundColor = .yellow
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
    func makeRecommendation(_ response: [RecommendItems]) {
        items = response
        cardCollectionView.reloadData()
    }
    
    func makeRecommendationFail(_ error: any Error) {
        let alert = UIAlertController(title: "", message: error.localizedDescription, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default){ action in
            alert.dismiss(animated: true)
            }
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension RecommendView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendCell.identifier, for: indexPath)
                as? RecommendCell else { return UICollectionViewCell() }
        return cell
    }
}

extension RecommendView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = 400
        let height: CGFloat = 500
        
        let size: CGSize = CGSize(width: width, height: height)
        
        return size
    }
}
