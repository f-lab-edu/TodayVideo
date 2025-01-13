//
//  ViewController.swift
//  TodayVideo
//
//  Created by iOS Dev on 12/30/24.
//

import UIKit
import SnapKit

final class SplashView: UIViewController {

    var presenter: SplashPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawUI()
    }

    private func drawUI() {
        self.view.backgroundColor = .red
        
//        let title1 = UILabel()
//        let title2 = UILabel()
//        let title3 = UILabel()
        
        
        presenter.showMain()
        
    }

}
