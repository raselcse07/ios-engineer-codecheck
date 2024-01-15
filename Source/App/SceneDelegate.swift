//
//  SceneDelegate.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        showInitialScreen()
    }
}

// MARK: - Flow
private extension SceneDelegate {
    func showInitialScreen() {
        let appCoordinator = AppCoordinator(navigationController: UINavigationController())
        window?.rootViewController = appCoordinator.start()
        window?.makeKeyAndVisible()
    }
}

