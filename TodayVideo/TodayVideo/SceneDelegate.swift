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
        navi.viewControllers = [splashView]//(rootViewController: splashView)
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navi
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}

}

