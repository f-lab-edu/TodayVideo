//
//  DetailView.swift
//  TodayVideo
//
//  Created by iOS Dev on 2/27/25.
//

import UIKit
import WebKit

protocol DetailViewProtocol {
    func makeDetailSuccess(with response: Decodable)
    func makeVideoSuccess(with response: DetailContentVideo)
    func makeDetailFail(_ error: Error)
}

final class DetailView: UIViewController {
    var presenter: DetailPresenterProtocol?
    
    let indicator = UIActivityIndicatorView(style: .large)
    var previousButton: PreviousButton!
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    var video = WKWebView()
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("")
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
//            make.top.leading.bottom.equalToSuperview()
//            make.width.equalTo(view.frame.size.width)
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func drawStackView() {
        scrollView.addSubview(stackView)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        
        stackView.snp.makeConstraints { make in
//            make.top.leading.bottom.equalToSuperview()
//            make.width.equalTo(view.frame.size.width)
            make.edges.width.equalToSuperview()
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
//        let halfCircle = UIView()
//        
//        halfCircle.backgroundColor = .cardBackground
//        halfCircle.roundCorners(cornerRadius: height / 2, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
//        
//        stackView.addArrangedSubview(halfCircle)
//        halfCircle.snp.makeConstraints { make in
//            let safeareaTop = view.safeAreaInsets.top
//            make.top.equalToSuperview().offset(-safeareaTop)
//            make.leading.trailing.equalToSuperview()
//            make.height.equalTo(height + safeareaTop)
//        }
        
        // film image
//        let filmImageView = UIImageView()
//        filmImageView.contentMode = .scaleAspectFill
//        filmImageView.tintColor = .black.withAlphaComponent(0.2)
//        ImageCache.shared.loadImage(posterPath) { image in
//            DispatchQueue.main.async {
//                filmImageView.image = image
//            }
//        }
//   
//        halfCircle.addSubview(filmImageView)
//        filmImageView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        
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
        let container = UIView()
        stackView.addArrangedSubview(container)
        
        let overviewLB = UILabel()
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
        container.addSubview(overviewLB)
        overviewLB.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.greaterThanOrEqualTo(20)
        }
    }
    
    private func drawVideo() {
        let container = UIView()
        stackView.addArrangedSubview(container)
        
        video = WKWebView()
        video.navigationDelegate = self
        container.addSubview(video)
        video.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        DispatchQueue.main.async {
            let embedURLString = "https://www.youtube.com/embed/G2VvqY9UNfE"
            let embedHTML = "<iframe width=\"100%\" height=\"100%\" src=\(embedURLString) frameborder=0 allowfullscreen></iframe>"
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
    
    func makeDetailSuccess(with response: Decodable) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            indicator.stopAnimating()
            
            if let tv = response as? DetailTVResponse {
                drawUI(by: tv)
            } else if let movie = response as? DetailMovieResponse {
                drawUI(by: movie)
            }
            
            view.bringSubviewToFront(previousButton)
        }
    }
    
    func makeVideoSuccess(with response: DetailContentVideo) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            drawVideo()
            if response.results.isEmpty {
                
            } else {
                
            }
        }
    }
    
    func makeDetailFail(_ error: any Error) {
        DispatchQueue.main.async {
            UIAlertController().fail(error: error, target: self)
        }
    }
}

extension DetailView: WKNavigationDelegate {
    
}
