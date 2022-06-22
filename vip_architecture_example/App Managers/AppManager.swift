//
//  AppManager.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 15/06/22.
//

import UIKit
import Swinject
import SwiftRouting

class AppManager{
    
    static var shared: AppManager = .init()
    
    private(set) weak var window: UIWindow?
    private(set) var notificationManager: NotificationManager!
    private(set) var assembler: Assembler!
    private(set) var startingRouter: BaseRouter!
    
    private init(){}
 
    
    func start(from window: UIWindow?) {
        self.window = window
        
        initDependencies()
        
        initNotificationManager()
        
        initStartScreen()
    }
    
}

// MARK: - App lifecycle
extension AppManager {
    
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
private extension AppManager{
    func initDependencies(){
        self.assembler = Assembler([
            RootAssembly(window: self.window!)
        ])
    }
    
    func initNotificationManager(){
        self.notificationManager = NotificationManager.initNotificationManager(with: [.alert, .badge, .sound])
        self.notificationManager.coordinatorDelegate = self
    }
    
    func initStartScreen(){
        let appRouter = assembler.resolver.resolve(IAppNavigator.self)!
        self.startingRouter = .init(appRouter, assembler: assembler)
        self.startingRouter.showRoute(route: .home(input: "Home Screen"))
    }
}

// MARK: - App Notification Management

extension AppManager{
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
extension AppManager{
    func handleDeepLink(deepLink: URL) {
        
    }
}
