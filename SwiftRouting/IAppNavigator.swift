//
//  IAppNavigator.swift
//  SwiftRouting
//
//  Created by Lorenzo Limoli on 15/06/22.
//

import UIKit

public enum PresentationType {
    case push
    case pushReplace
    case present
    case presentWithNavigation
}

public enum RootType{
    /// Instantiate a simple UINavigationController as Root and set the controller as first controller
    case singleStack(controller: UIViewController, customStack: UINavigationController? = nil)
    
    /// Instantiate a simple UITabBarController with a single navigation stack as Root
    case singleStackTabBar(
        tabBarInfoProvider: TabBarInfoProvider,
        customTabBarController: UITabBarController? = nil,
        customStack: UINavigationController? = nil)
    
    /// Instantiate UITabBarController as Root with a different navigation stack for each Tab
    case multiStackTabBar(
        tabBarInfoProvider: TabBarInfoProvider,
        customTabBarController: UITabBarController? = nil,
        customStackFactory: (() -> UINavigationController)? = nil)
    
    fileprivate var isTabBar: Bool{
        switch self {
        case .singleStackTabBar, .multiStackTabBar: return true
        default: return false
        }
    }
}

public protocol IAppNavigator: AnyObject{
    
    var window: UIWindow! { get set }

    func setRootController(rootType: RootType, animated: Bool)
    func setCustomRootController(controller: UIViewController)
    
    func go(from: UIViewController, to: UIViewController, presentationType: PresentationType, completion: (() -> Void)?, animated: Bool)
    
    
    func back(from: UIViewController, to: UIViewController, completion: (() -> Void)?, animated: Bool)
    
    @discardableResult
    func back<To: UIViewController>(from: UIViewController, to type: To.Type, completion: (() -> Void)?, animated: Bool) -> Bool
    
    
    
    func dismiss(_ controller: UIViewController, completion: (() -> Void)?, animated: Bool)
}

public extension IAppNavigator{
    
    func setRootController(rootType: RootType, animated: Bool = true){
        let root: UIViewController
        
        switch rootType {
        case .singleStack(let controller, let customStack):
            
            let navigationController = customStack ?? UINavigationController()
            
            navigationController.setViewControllers([controller], animated: animated)
            
            root = navigationController
            
        case .singleStackTabBar(
            let tabBarInfoProvider,
            let customTabBarController,
            let customStack):
            
            let navigationController = customStack ?? UINavigationController()
            
            let tabBarController = customTabBarController ?? UITabBarController()
            
            let controllers: [UIViewController] = tabBarInfoProvider.itemsInfo.map{ item in
                let viewController = item.viewController()
                viewController.tabBarItem = item.tabBarItem
                return viewController
            }
            
            tabBarController.viewControllers = controllers
            
            navigationController.setViewControllers([tabBarController], animated: animated)
            
            root = navigationController
            
        case .multiStackTabBar(
            let tabBarInfoProvider,
            let customTabBarController,
            let customStackFactory):
            
            let tabBarController = customTabBarController ?? UITabBarController()
            
            let controllers: [UINavigationController] = tabBarInfoProvider.itemsInfo.map{ item in
                let viewController = item.viewController()
                viewController.tabBarItem = item.tabBarItem
                
                let navigationController = customStackFactory?() ?? UINavigationController()
                
                navigationController.setViewControllers([viewController], animated: animated)
                
                return navigationController
            }
            
            tabBarController.viewControllers = controllers
            
            root = tabBarController
        }
        
        window.rootViewController = root
        window.makeKeyAndVisible()
    }
    
    func setCustomRootController(controller: UIViewController){
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
    
    func go(
        from: UIViewController,
        to: UIViewController,
        presentationType: PresentationType = .push,
        completion: (() -> Void)? = nil,
        animated: Bool = true
    ){
        
        
        switch presentationType {

        case .push:
            guard let navCon = from.navigationController else {
                fatalError("Cannot find navigation controller. Please use one as root to push new controllers")
            }
            
            navCon.pushViewController(to, animated: animated, completion: completion)
            
        case .pushReplace:
            
            guard let navCon = from.navigationController else {
                fatalError("Cannot find navigation controller. Please use one as root to push new controllers")
            }
            
            let controllersCount = navCon.viewControllers.count
            var excludingLastController = Array(navCon.viewControllers[0..<controllersCount-1])
            excludingLastController.append(to)
            navCon.setViewControllers([], animated: animated)
            
            completion?()
            
        case .present:
            
            from.present(to, animated: animated, completion: completion)
            
        case .presentWithNavigation:
            
            let newNavCon = UINavigationController(rootViewController: to)
            
            from.present(newNavCon, animated: animated, completion: completion)
        }
    }
    
    func back(
        from: UIViewController,
        to: UIViewController,
        completion: (() -> Void)? = nil,
        animated: Bool = true
    ){
        
        guard let navCon = from.navigationController else {
            fatalError("Cannot find navigation controller. Please use one as root to push new controllers")
        }
        
        navCon.popToViewController(to, animated: animated, completion: completion)
    }

    func back<To: UIViewController>(
        from: UIViewController,
        to type: To.Type,
        completion: (() -> Void)? = nil,
        animated: Bool = true
    ) -> Bool{
        
        guard let navCon = from.navigationController else {
            fatalError("Cannot find navigation controller. Please use one as root to push new controllers")
        }
        
        guard let controller = navCon.viewControllers.last(where: { $0 is To }),
                let routedController = controller as? To else {
            return false
        }
        
        back(from: from, to: routedController, completion: completion, animated: animated)
        
        return true
    }
    
    
    func dismiss(
        _ controller: UIViewController,
        completion: (() -> Void)? = nil,
        animated: Bool = true
    ){
        
        if let navCon = controller.navigationController{
            navCon.popViewController(animated: true, completion: completion)
        }
        
        controller.dismiss(animated: animated, completion: completion)
    }
}
