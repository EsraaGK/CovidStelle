//
//  AppDelegate+LocalNotification.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/14/20.
//

import Foundation
import UserNotifications

extension AppDelegate {
    
    func registerAppForNotification() {
        NotificationService.shared.registerAppForNotification()
    }
    
}
