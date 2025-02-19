//
//  RecommendCell.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/18/25.
//

import UIKit

class RecommendCell: UICollectionViewCell {
    static let identifier = "RecommendCell"
    private let leftRightMargin = 50
    
    var poster = UIImageView()
    var title = UILabel()
    var genre = UILabel()
    var year = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        drawUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawUI() {
        contentView.addSubview(poster)
        contentView.addSubview(title)
        contentView.addSubview(genre)
        contentView.addSubview(year)
        
        makePoster()
        makeTitle()
        makeGenre()
        makeYear()
    }
    
    private func makePoster() {
        let rate = 1.4
        poster.layer.cornerRadius = 30
        poster.backgroundColor = .cardBackground
        poster.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(leftRightMargin)
            make.height.equalTo(frame.height / rate)
        }
    }
    
    private func makeTitle() {
        title.numberOfLines = 0
        title.textAlignment = .center
        title.textColor = .buttonDefaultText
        title.snp.makeConstraints { make in
            make.top.equalTo(poster.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(leftRightMargin)
        }
    }
    
    private func makeGenre() {
        genre.numberOfLines = 0
        genre.textAlignment = .center
        genre.textColor = .buttonDefaultText
        genre.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(7)
            make.leading.trailing.equalToSuperview().inset(leftRightMargin)
        }
    }
    
    private func makeYear() {
        year.numberOfLines = 1
        year.textAlignment = .center
        year.textColor = .buttonDefaultText
        year.snp.makeConstraints { make in
            make.top.equalTo(genre.snp.bottom).offset(7)
            make.leading.trailing.equalToSuperview().inset(leftRightMargin)
            make.bottom.equalToSuperview()
        }
    }
    
    func configTVCell(with item: RecommendTVResponse.Items) {
        title.text = item.name
        genre.text = "item.genreIds[0]"
        year.text = item.firstAirDate
    }
    
    func configMovieCell(with item: RecommendMovieResponse.Items) {
        title.text = item.title
        genre.text = "item.genreIds[0]"
        year.text = item.releaseDate
    }
}
