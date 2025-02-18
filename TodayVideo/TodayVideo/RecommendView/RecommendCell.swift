//
//  RecommendCell.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/18/25.
//

import UIKit

class RecommendCell: UICollectionViewCell {
    static let identifier = "RecommendCell"
    
    let poster = UIImageView()
    let title = ""
    let genre = ""
    let year = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        drawUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawUI() {
        makePoster()
    }
    
    private func makePoster() {
        let height = self.bounds.size.height / 1.4
        
        contentView.addSubview(poster)
        poster.layer.cornerRadius = 30
        poster.backgroundColor = . cardBackground
//        poster.frame = contentView.bounds
//        poster.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.centerX.equalToSuperview()
//            make.width.equalTo(200)
//            make.height.equalTo(height)
//        }
    }
}
