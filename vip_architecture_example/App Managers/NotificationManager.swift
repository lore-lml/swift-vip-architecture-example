//
//  NotificationManager.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 15/06/22.
//

import UIKit
import UserNotifications
//import Firebase

class NotificationManager: NSObject{
    
    private(set) static var shared = NotificationManager()
    
    private var _deviceToken: Data?
//    private(set) var fcmToken: String?
    private(set) var notificationEnabled: Bool?
    
    weak var coordinatorDelegate: AppManager?
    
    var deviceToken: String?{
        guard let token = _deviceToken else{
            return nil
        }
        
        let tokenParts = token.map { data in String(format: "%02.2hhx", data) }
        return tokenParts.joined()
    }
    
    private override init(){
        super.init()
        UNUserNotificationCenter.current().delegate = self
//        Messaging.messaging().delegate = self
    }
    
    static func initNotificationManager(with options: UNAuthorizationOptions) -> NotificationManager{
        
        UNUserNotificationCenter.current()
            .requestAuthorization(options: options){ success, _ in

                shared.registerForRemoteNotifications()
        }
        
        shared.registerForRemoteNotifications()
        return shared
    }
    
    func registerForRemoteNotifications() {
      UNUserNotificationCenter.current().getNotificationSettings { settings in
          guard settings.authorizationStatus == .authorized else { self.notificationEnabled = false; return }
          self.notificationEnabled = true
          
          DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
          }
      }
    }
    
}

//MARK: Notification Center Delegate
extension NotificationManager: UNUserNotificationCenterDelegate{
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {

    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        self._deviceToken = deviceToken
//        Messaging.messaging().apnsToken = deviceToken
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {

    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler( [.alert, .sound, .badge] )
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        completionHandler()
    }
}


// MARK: Firebase Messaging Delegate
//extension NotificationManager: MessagingDelegate{
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//        guard let token = fcmToken else{
//            return
//        }
//
//        self.fcmToken = token
//    }
//}
