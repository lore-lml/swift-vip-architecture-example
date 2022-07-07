//
//  IAppNavigator.swift
//  SwiftRouting
//
//  Created by Lorenzo Limoli on 15/06/22.
//

import UIKit

public enum PresentationType {
    /// A new UIViewController is added to the navigation stack
    case push
    /// A new UIViewController replace the current UIViewController
    case pushReplace
    /// A new UIViewController is presented modally
    case present
    /// A new UIViewController is added to a new navigation stack presented modally
    case presentWithNavigation(customStack: UINavigationController? = nil)
    /// A new UIViewController is presented in a bottom sheet controller
    case bottomSheet(desiredHeight: CGFloat? = nil)
    /// A new UIViewController is added to a new navigation stack presented in a bottom sheet controller
    case bottomSheetWithNavigation(desiredHeight: CGFloat? = nil, customStack: UINavigationController? = nil)
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

    /// Set the root view controller chosing among a predefined configurations
    func setRootController(rootType: RootType, animated: Bool)
    /// Set the root view controller
    func setCustomRootController(controller: UIViewController)
    
    /// Create a new route from a source controller towards a destination controller using the selected presentation type
    func go(from: UIViewController, to: UIViewController, presentationType: PresentationType, completion: (() -> Void)?, animated: Bool)
    
    
    /// Go back to the provided controller if it is part of a navigation stack
    @discardableResult
    func backTo(controller: UIViewController, completion: (() -> Void)?, animated: Bool) -> Bool
    
    /// Go back to the controller of the provided Type if present in the navigation stack of the source controller.
    @discardableResult
    func back<To: UIViewController>(from: UIViewController, to type: To.Type, completion: (() -> Void)?, animated: Bool) -> Bool
    
    
    /// Pop the provided controller out of the navigation stack if it is the top view controller, or dismiss it if it is presented modally
    @discardableResult
    func popOrDismiss(_ controller: UIViewController, completion: (() -> Void)?, animated: Bool) -> Bool
    
    /// Dismiss the view controller if it is presented modally, or the entire navigation stack if the root has been presented modally
    @discardableResult
    func dismissModal(_ controller: UIViewController, completion: (() -> Void)? , animated: Bool) -> Bool
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
            
        case .presentWithNavigation(let customStack):
            
            let newNavCon = customStack ?? .init()
            
            newNavCon.viewControllers = [to]
            
            from.present(newNavCon, animated: animated, completion: completion)
            
        case .bottomSheet(let desiredHeight):
            from.presentInBottomSheetController(to, withHeight: desiredHeight, animated: animated)
            
        case .bottomSheetWithNavigation(let desiredHeight, let customStack):
            let newNavCon = customStack ?? .init()
            
            newNavCon.viewControllers = [to]
            
            from.presentInBottomSheetController(newNavCon, withHeight: desiredHeight, animated: animated)
        }
    }
    
    @discardableResult
    func backTo(
        controller: UIViewController,
        completion: (() -> Void)?,
        animated: Bool
    ) -> Bool{
        
        guard let navCon = controller.navigationController else {
            return false
        }
        
        navCon.popToViewController(controller, animated: animated, completion: completion)
        return true
    }

    @discardableResult
    func back<To: UIViewController>(
        from: UIViewController,
        to type: To.Type,
        completion: (() -> Void)? = nil,
        animated: Bool = true
    ) -> Bool{
        
        guard let navCon = from.navigationController else {
            return false
        }
        
        guard let controller = navCon.viewControllers.last(where: { $0 is To }),
                let routedController = controller as? To else {
            return false
        }
        
        backTo(controller: routedController, completion: completion, animated: animated)
        
        return true
    }
    
    @discardableResult
    func popOrDismiss(
        _ controller: UIViewController,
        completion: (() -> Void)? = nil,
        animated: Bool = true
    ) -> Bool{
        
        if let navCon = controller.navigationController{
            if navCon.topViewController === controller{
                navCon.popViewController(animated: true, completion: completion)
                return true
            }
            return false
        }
        
        if controller.isModal{
            controller.dismiss(animated: animated, completion: completion)
            return true
        }
        
        return false
    }
    
    @discardableResult
    func dismissModal(
        _ controller: UIViewController,
        completion: (() -> Void)? = nil ,
        animated: Bool = true
    ) -> Bool{
        
        if !controller.isModal{
            return false
        }
        
        if let navCon = controller.navigationController{
            navCon.dismiss(animated: animated, completion: completion)
            return true
        }
        
        controller.dismiss(animated: animated, completion: completion)
        return true
    }
}
