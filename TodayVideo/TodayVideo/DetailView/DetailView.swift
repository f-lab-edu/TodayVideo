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
    var videos = [DetailContentVideo.Item]()
    var timerForShowScrollIndicator: Timer?
    
    let indicator = UIActivityIndicatorView(style: .large)
    var previousButton: PreviousButton!
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    let videoCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ui
        view.backgroundColor = .background
        previousButton = PreviousButton(location: self)
        makeIndicator()
        
        // api
        presenter?.fetchDetail()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        startTimerVideoScrollIndicator()
        videoScrollIndicatorColor()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        timerForShowScrollIndicator = nil
    }

    private func makeIndicator() {
        view.addSubview(indicator)
        
        indicator.center = view.center
        indicator.color = .buttonSelectedBackground
        indicator.startAnimating()
    }
    
    private func videoScrollIndicatorColor() {
        DispatchQueue.main.async {
            self.videoCollection.scrollIndicators.vertical?.backgroundColor = .buttonSelectedBackground
        }
    }
    
    private func startTimerVideoScrollIndicator() {
        self.timerForShowScrollIndicator = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.showScrollIndicatorsInContacts), userInfo: nil, repeats: true)
    }
    
    @objc private func showScrollIndicatorsInContacts() {
        UIView.animate(withDuration: 1.5) {
            self.videoCollection.flashScrollIndicators()
        }
    }
    
    private func drawScrollView() {
        view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func drawStackView() {
        scrollView.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 20

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view.frame.size.width)
        }
    }

    private func drawTopPoster(with posterPath: String?) {
        // 상단 circle 포스터 이미지
        let rate = 2.4
        let height = view.frame.size.height / rate
        
        let contatiner = UIView()
        stackView.addArrangedSubview(contatiner)
        contatiner.snp.makeConstraints { make in
            make.height.equalTo(height)
        }
        
        let filmImageView = UIImageView()
        let radius = height / 2
        filmImageView.contentMode = .scaleAspectFill
        filmImageView.tintColor = .black.withAlphaComponent(0.2)
        filmImageView.roundCorners(cornerRadius: radius, maskedCorners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        
        if let posterPath = posterPath {
            ImageCache.shared.loadImage(posterPath) { image in
                DispatchQueue.main.async {
                    filmImageView.image = image
                }
            }
        }
        
        contatiner.addSubview(filmImageView)
        filmImageView.snp.makeConstraints { make in
//            make.height.equalTo(height)
            make.width.equalTo(view.frame.size.width)
            make.edges.equalToSuperview()
        }

        
    }
    
    private func drawTitle(_ title: String?) {
        if let title = title {
            let contatiner = UIView()
            stackView.addArrangedSubview(contatiner)
            let titleLB = UILabel()
            titleLB.textAlignment = .left
            titleLB.numberOfLines = 0
            titleLB.lineBreakMode = .byWordWrapping
            titleLB.text = title
            titleLB.font = .boldSystemFont(ofSize: 22)
            titleLB.textColor = .white
            contatiner.addSubview(titleLB)
            titleLB.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(16)
            }
        }
    }
    
    private func drawInformation(_ information: String) {
        let container = UIView()
        stackView.addArrangedSubview(container)
        
//        let informationLB = UILabel()
//        let aa = "MutableAttributedString(string: information)MutableAttributedString(string: information)"
//        let attrString = NSMutableAttributedString(string: aa)
//        let paragraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = 4
//        attrString.addAttribute(NSAttributedString.Key.paragraphStyle,
//                                value: paragraphStyle,
//                                range: NSRange(location: 0, length: attrString.length))
//        
//        
//        informationLB.numberOfLines = 0
//        informationLB.font = .systemFont(ofSize: 16)
//        informationLB.textColor = .white
//        informationLB.attributedText = attrString
//        informationLB.textAlignment = .center
//        container.addSubview(informationLB)
//        informationLB.snp.makeConstraints { make in
////            make.top.equalToSuperview().offset(4)
//            make.leading.trailing.equalToSuperview().inset(16)
////            make.bottom.equalToSuperview().offset(-12)
//        }
    }

    private func drawOverview(_ overview: String?) {
        if let overview = overview {
            let overviewLB = UILabel()
            let attrString = NSMutableAttributedString(string: overview)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 4
            attrString.addAttribute(NSAttributedString.Key.paragraphStyle,
                                    value: paragraphStyle,
                                    range: NSRange(location: 0, length: attrString.length))
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
    }
    
    private func drawVideo() {
//        let container = UIView()
//        stackView.addArrangedSubview(container)
        
        let width = view.frame.size.width
        let height = (width * 9) / 16
        
//        container.snp.makeConstraints { make in
//            make.height.equalTo(height + 20)
//        }
        
        videoCollection.register(VideoCell.self, forCellWithReuseIdentifier: VideoCell.id)
        videoCollection.delegate = self
        videoCollection.dataSource = self
        videoCollection.isPagingEnabled = true
        videoCollection.showsVerticalScrollIndicator = false
        videoCollection.flashScrollIndicators()
//        container.addSubview(videoCollection)
        stackView.addArrangedSubview(videoCollection)
        
        videoCollection.snp.makeConstraints { make in
            //make.top.equalToSuperview().offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(height)
//            make.bottom.equalToSuperview()
        }
    }
    
    private func makeProvider() {
        // 제공업체 로고
        let provierImageView = UIImageView()
        provierImageView.image = .netflix
        provierImageView.contentMode = .scaleAspectFit
        view.addSubview(provierImageView)
        provierImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(27.27)
            make.trailing.equalToSuperview().offset(-41.6)
            make.width.height.equalTo(50)
        }
    }
}

// MARK: - DetailViewProtocol
extension DetailView: DetailViewProtocol {
    private func genreName(by genres: [Genre]?) -> String {
        guard let genres = genres else { return "" }
        let result = genres.map { $0.name! }
        return result.joined(separator: " ・ ")
    }
    
    private func information(with response: DetailResponse) -> String {
        var information: [String] = []
        
        let genres = response.genres
        let genreString = genreName(by: genres)
        if !genreString.isEmpty {
            information.append(genreString)
        }
        
        let date = (response.date ?? "").prefix(4)
        if !date.isEmpty {
            information.append("\(date)년")
        }
        
        let runTime = response.runtime ?? 0
        if runTime > 0 {
            information.append("\(runTime)분")
        }
        
        return information.joined(separator: "\n")
    }
    
    private func drawUI(by response: DetailResponse) {
        drawScrollView()
        drawStackView()
        drawTopPoster(with: response.backdropPath)
        drawTitle(response.title)
        drawInformation(information(with: response))
//        drawOverview(response.overview)
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
            
//            if !video.results.isEmpty {
//                videos = video.results
//                drawVideo()
//            }
            
            view.bringSubviewToFront(previousButton)
        }
    }
    
    func makeDetailFail(_ error: any Error) {
        DispatchQueue.main.async {
            UIAlertController().fail(error: error, target: self)
        }
    }
}

// MARK: - video collectionView
extension DetailView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCell.id, for: indexPath) as? VideoCell else { return UICollectionViewCell() }
        let video = videos[indexPath.item]
        
        cell.config(with: video.site, key: video.key)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width - 32
        let height = (width * 9) / 16
        
        return CGSize(width: width, height: height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        DispatchQueue.main.async {
            if scrollView == self.videoCollection {
                scrollView.scrollIndicators.vertical?.backgroundColor = .buttonSelectedBackground
            }
        }
    }
}
