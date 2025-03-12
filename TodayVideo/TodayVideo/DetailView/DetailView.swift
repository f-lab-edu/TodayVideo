//
//  DetailView.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/27/25.
//

import UIKit
import WebKit
import SnapKit

protocol DetailViewProtocol {
    func makeDetailSuccess(response: Decodable, video: DetailContentVideo)
    func makeDetailFail(_ error: Error)
}

final class DetailView: UIViewController {
    var presenter: DetailPresenterProtocol?
    
    let indicator = UIActivityIndicatorView(style: .large)
    var previousButton: PreviousButton!
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let overviewLB = UILabel()
    let video = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ui
        view.backgroundColor = .background
        previousButton = PreviousButton(location: self)
        makeIndicator()
        drawScrollView()
        drawStackView()
        
        // api
        presenter?.fetchDetail()
    }
    
    private func makeIndicator() {
        view.addSubview(indicator)
        
        indicator.center = view.center
        indicator.color = .buttonSelectedBackground
        indicator.startAnimating()
    }
    
    private func drawScrollView() {
        view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func drawStackView() {
        scrollView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0
        
        stackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(scrollView.contentLayoutGuide)
            make.bottom.equalToSuperview().offset(-17)
            make.width.equalTo(scrollView.frameLayoutGuide.snp.width)
        }
    }

    private func drawTopPoster(with posterPath: String) {
        // circle
        let rate = 2.4
        let height = self.view.frame.size.height / rate
        let filmImageView = UIImageView()
        
        filmImageView.contentMode = .scaleAspectFill
        filmImageView.tintColor = .black.withAlphaComponent(0.2)
        filmImageView.roundCorners(cornerRadius: height / 2, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        ImageCache.shared.loadImage(posterPath) { image in
            DispatchQueue.main.async {
                filmImageView.image = image
            }
        }
        stackView.addArrangedSubview(filmImageView)
        filmImageView.snp.makeConstraints { make in
            let safeareaTop = view.safeAreaInsets.top
            make.top.equalToSuperview()//.offset(-safeareaTop)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(height)
        }

//        // 제공업체 로고
//        let provierImageView = UIImageView()
//        provierImageView.image = .netflix
//        provierImageView.contentMode = .scaleAspectFit
//        filmImageView.addSubview(provierImageView)
//        provierImageView.snp.makeConstraints { make in
//            make.centerY.equalTo(previousButton.snp.centerY)
//            make.trailing.equalToSuperview().offset(-14)
//            make.width.height.equalTo(50)
//        }
    }
    
    private func drawTitle(_ title: String) {
        let container = UIView()
        stackView.addArrangedSubview(container)
        
        let titleLB = UILabel()
        titleLB.textAlignment = .center
        titleLB.numberOfLines = 0
        titleLB.lineBreakMode = .byWordWrapping
        titleLB.text = title
        titleLB.font = .boldSystemFont(ofSize: 22)
        titleLB.textColor = .white
        container.addSubview(titleLB)
        titleLB.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    private func drawInformation(information: String) {
        let container = UIView()
        stackView.addArrangedSubview(container)
        
        let informationLB = UILabel()
        let attrString = NSMutableAttributedString(string: information)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        informationLB.attributedText = attrString
        informationLB.textAlignment = .center
        informationLB.numberOfLines = 0
        informationLB.font = .systemFont(ofSize: 16)
        informationLB.textColor = .white
        container.addSubview(informationLB)
        informationLB.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    private func genreName(by genres: [Genre]?) -> String {
        guard let genres = genres else { return "" }
        let result = genres.map { $0.name! }
        return result.joined(separator: " ・ ")
    }
    
    private func drawOverview(_ overview: String) {
        let attrString = NSMutableAttributedString(string: overview)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        overviewLB.attributedText = attrString
        overviewLB.textAlignment = .left
        overviewLB.numberOfLines = 0
        overviewLB.font = .systemFont(ofSize: 16)
        overviewLB.textColor = .white
        overviewLB.lineBreakMode = .byWordWrapping
        stackView.addArrangedSubview(overviewLB)
        overviewLB.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    private func drawVideo() {
        let container = UIView()
        stackView.addArrangedSubview(container)
        container.addSubview(video)
        video.scrollView.bounces = false
        
        let width = view.frame.size.width
        let height = (width * 9) / 16
        
        container.snp.makeConstraints { make in
            make.height.equalTo(height + 20)
        }
        video.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(height)
            make.bottom.equalToSuperview()
        }
        
        DispatchQueue.main.async {
            let embedURLString = "https://www.youtube.com/embed/G2VvqY9UNfE"
            let embedHTML = """
<meta name="viewport" content="width=device-width,minimum-scale=0.95,initial-scale=0.95,user-scalable=no">
<iframe src="\(embedURLString)" width="\(width)px" height="\(height)px" marginwidth="0" marginheight="0" frameborder="0" scrolling="no" ></iframe>
"""
            self.video.loadHTMLString(embedHTML, baseURL: nil)
        }
    }
}

extension DetailView: DetailViewProtocol {
    private func drawUI(by response: DetailResponse) {
        drawTopPoster(with: response.backdropPath)
        
        drawTitle(response.title)
        
        let genres = response.genres
        let genreString = genreName(by: genres)
        let date = (response.date).prefix(4)
        let runTime = response.runtime
        drawInformation(information: "\(genreString)\n\(date)년\n\(runTime)분")
        
        drawOverview(response.overview)
    }
    
    func makeDetailSuccess(response: Decodable, video: DetailContentVideo) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            indicator.stopAnimating()
            
            if let tv = response as? DetailTVResponse {
                drawUI(by: tv)
            } else if let movie = response as? DetailMovieResponse {
                drawUI(by: movie)
            }
            
            drawVideo()
            if video.results.isEmpty {
                
            } else {
                
            }
            
            view.bringSubviewToFront(previousButton)
        }
    }
    
    func makeDetailFail(_ error: any Error) {
        DispatchQueue.main.async {
            UIAlertController().fail(error: error, target: self)
        }
    }
}
