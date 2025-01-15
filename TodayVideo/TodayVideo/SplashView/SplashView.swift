//
//  ViewController.swift
//  TodayVideo
//
//  Created by iOS Dev on 12/30/24.
//

import UIKit
import SnapKit

final class SplashView: UIViewController {
    var presenter: SplashPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawUI()
    }
    
    func drawUI() {
        self.view.backgroundColor = .background
        
        let title1 = UILabel()
        let title2 = UILabel()
        let title3 = UILabel()
        
        [title1, title2, title3].forEach { title in
            title.text = "오늘뭐봄?!"
            title.font = .systemFont(ofSize: 48.0, weight: .black)
            title.textAlignment = .center
            self.view.addSubview(title)
        }
        
        title1.textColor = .title1
        title2.textColor = .title2
        title3.textColor = .title3
        
        title3.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        title2.snp.makeConstraints { make in
            make.centerX.equalTo(title3.snp.centerX).offset(2)
            make.centerY.equalTo(title3)
        }
        title1.snp.makeConstraints { make in
            make.centerX.equalTo(title3.snp.centerX).offset(-4)
            make.centerY.equalTo(title3)
        }
    }
}

