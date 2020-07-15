//
//  SceneDelegate.swift
//  main
//
//  Created by Matheus Lima Gomes on 13/07/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = SignupFactory.makeController()
        window?.makeKeyAndVisible()
    }
}

