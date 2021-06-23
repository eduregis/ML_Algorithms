//
//  SceneDelegate.swift
//  ML_Algorithms
//
//  Created by Eduardo Oliveira on 17/06/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let VC = ViewController()
        window?.rootViewController = VC
        window?.makeKeyAndVisible()
    }
}

