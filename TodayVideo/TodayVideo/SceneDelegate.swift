//
//  SceneDelegate.swift
//  TodayVideo
//
//  Created by iOS Dev on 12/30/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let splashView = SplashRouter.createSplashViewModule()
        let navi = UINavigationController()
        navi.viewControllers = [splashView]
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navi
        window?.makeKeyAndVisible()
    }
}
