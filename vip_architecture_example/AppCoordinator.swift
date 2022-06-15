//
//  AppCoordinator.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 15/06/22.
//

import UIKit

class AppCoordinator{
    
    static var shared: AppCoordinator = .init()
    
    private(set) weak var window: UIWindow?
    private(set) var notificationManager: NotificationManager!
    
    private init(){}
 
    
    func start(from window: UIWindow?) {
        self.window = window
        
        initializeAppRouter()
        initNotificationManager()
    }
    
}

// MARK: - App lifecycle
extension AppCoordinator {
    
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {

    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
}


//MARK: Service Initializers
private extension AppCoordinator{
    func initializeAppRouter(){
        AppRouter.initialize(window: window)
        AppRouter.instance.setRootController(ofType: HomeViewController.self, presentationInput: "CIAONE")
    }
    
    func initNotificationManager(){
        self.notificationManager = NotificationManager.initNotificationManager(with: [.alert, .badge, .sound])
        self.notificationManager.coordinatorDelegate = self
    }
}

// MARK: - App Notification Management

extension AppCoordinator{
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        //Log.i("applicationDidFailToRegisterForRemoteNotificationsWithError")
        notificationManager.application(application, didFailToRegisterForRemoteNotificationsWithError: error)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        notificationManager.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        //Log.i("applicationDidReceiveRemoteNotification")
        
        notificationManager.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
    }
}

// MARK: Callback DEEPLINK URL
extension AppCoordinator{
    func handleDeepLink(deepLink: URL) {
        
    }
}
