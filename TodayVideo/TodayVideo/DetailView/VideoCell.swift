//
//  VideoCell.swift
//  TodayVideo
//
//  Created by iOS Dev on 3/12/25.
//

import UIKit
import WebKit
import SnapKit

enum VideoSite: String {
    case youTube = "YouTube"
}

class VideoCell: UICollectionViewCell {
    static let id = "VideoCell"
    
    let video = WKWebView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(video)
        video.scrollView.isScrollEnabled = false
        video.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(with site: String, key: String) {
        guard site == VideoSite.youTube.rawValue else { return }
        
        let url = "https://www.youtube.com/embed/\(key)"
        let width = Int(contentView.frame.size.width)
        let height = Int((contentView.frame.size.width * 9) / 16)
        let embedHTML = """
        <meta name="viewport" content="width=device-width,minimum-scale=1.0,initial-scale=1.0,user-scalable=no">
        <style>body{margin:0;padding:0;}</style>
        <iframe src="\(url)" width="\(width)px" height="\(height)px" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" ></iframe>
        """
        
        DispatchQueue.main.async {
            self.video.loadHTMLString(embedHTML, baseURL: nil)
        }
    }
}
