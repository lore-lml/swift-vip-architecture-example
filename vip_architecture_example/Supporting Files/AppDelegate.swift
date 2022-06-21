//
//  AppDelegate.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 13/06/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appCoordinator: AppManager!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        appCoordinator = AppManager.shared
        return true
    }

    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}


//MARK: - Remote Notifications
//extension AppDelegate: UNUserNotificationCenterDelegate {
//    
//    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        
//        appCoordinator.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
//    }
//    
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        
//        appCoordinator.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
//    }
//    
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        
//        appCoordinator.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
//    }
//}
