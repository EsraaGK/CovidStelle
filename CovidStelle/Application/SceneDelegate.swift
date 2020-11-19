//
//  SceneDelegate.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/16/20.
//

import UIKit
import RxSwift
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let viewModel = AppManager.shared.getContentViewViewModel()
    let disposeBag = DisposeBag()
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
         window = UIWindow(windowScene: windowScene)
        let mainVC = AppManager.shared.getContentView()
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        BackGroundTaskService.shared.scheduleGetCovidStatistics()
    }
}
