//
//  Router.swift
//  TodayVideo
//
//  Created by iOS Dev on 12/30/24.
//

import UIKit

protocol SplashRouterProtocol {
    func showMain()
}

final class SplashRouter {
    let presentingViewController: UIViewController
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    func showMain() {
        guard let navigationController = presentingViewController.navigationController else { return }
        let main = UIViewController()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            navigationController.pushViewController(main, animated: true)
        }
    }
}
