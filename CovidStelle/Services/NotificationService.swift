//
//  NotificationService.swift
//  CovidStelle
//
//  Created by EsraaGK on 11/15/20.
//

import Foundation
import NotificationCenter

class NotificationService {
    static let shared = NotificationService()
    private let notificationCenter = UNUserNotificationCenter.current()
    
    public func registerAppForNotification() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        notificationCenter.requestAuthorization(options: options) { (didAllow, _) in
            if !didAllow {
                print("User has declined notifications")
            }
        }
    }
    
    func createNotification(state: String) -> UNMutableNotificationContent {
        
        let content = UNMutableNotificationContent()
        content.title = "Latest Update for Covid-19"
        content.body = state
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        return content
    }
    
    public func fireNotification(state: String) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        
        let identifier = UUID().uuidString
        let request = UNNotificationRequest(identifier: identifier,
                                            content: createNotification(state: state),
                                            trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
}
