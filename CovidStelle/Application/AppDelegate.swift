//
//  AppDelegate.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/16/20.
//

import UIKit
import CoreLocation
import RxSwift
import os.log
import BackgroundTasks

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let viewModel = AppManager.shared.getContentViewViewModel()
    let disposeBag = DisposeBag()
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        registerAppForNotification()
        BackGroundTaskService.shared.registerBackgroundTask()
        UIApplication.shared.applicationIconBadgeNumber = 0
        viewModel.scedualeForgroundUpdate()
        return true
    }
    
}
