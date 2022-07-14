//
//  IAppNavigator.swift
//  SwiftRouting
//
//  Created by Lorenzo Limoli on 15/06/22.
//

import UIKit

public typealias CustomNavigationHandler = (UINavigationController?, UIViewController?, UIViewController) -> Void

public enum PresentationType {
    /// A new UIViewController is added to the navigation stack
    /// - Parameter animated: Specifies if the presentation transition is animated or not
    /// - Parameter completion: Action performed after presentation has been performed
    case push(
        animated: Bool = true,
        completion: (() -> Void)? = nil
    )
    
    /// A new UIViewController replace the current UIViewController
    /// - Parameter animated: Specifies if the presentation transition is animated or not
    /// - Parameter completion: Action performed after presentation has been performed
    case pushReplace(
        animated: Bool = true,
        completion: (() -> Void)? = nil
    )
    
    /// A new UIViewController is presented modally
    /// - Parameter animated: Specifies if the presentation transition is animated or not
    /// - Parameter completion: Action performed after presentation has been performed
    case present(
        animated: Bool = true,
        completion: (() -> Void)? = nil
    )
    
    /// A new UIViewController is added to a new navigation stack presented modally
    /// - Parameter animated: Specifies if the presentation transition is animated or not
    /// - Parameter completion: Action performed after presentation has been performed
    /// - Parameter customStack: If not nil, the source controller will use this custom navigation controller instead of the default one
    case presentWithNavigation(
        animated: Bool = true,
        completion: (() -> Void)? = nil,
        customStack: UINavigationController? = nil
    )
    
    /// A new UIViewController is presented in a bottom sheet controller
    /// - Parameter animated: Specifies if the presentation transition is animated or not
    /// - Parameter completion: Action performed after presentation has been performed
    /// - Parameter desiredHeight: Set the desired height for the bottom sheet controller
    case bottomSheet(
        animated: Bool = true,
        completion: (() -> Void)? = nil,
        desiredHeight: CGFloat? = nil
    )
    
    /// A new UIViewController is added to a new navigation stack presented in a bottom sheet controller
    /// - Parameter animated: Specifies if the presentation transition is animated or not
    /// - Parameter completion: Action performed after presentation has been performed
    /// - Parameter desiredHeight: Set the desired height for the bottom sheet controller
    /// - Parameter customStack: If not nil, the source controller will use this custom navigation controller instead of the default one
    case bottomSheetWithNavigation(
        animated: Bool = true,
        completion: (() -> Void)? = nil,
        desiredHeight: CGFloat? = nil,
        customStack: UINavigationController? = nil
    )
    
    /// Custom implementation of a navigation:
    /// - Parameter navigationHandler custom navigation Handler:
    ///     - Parameter navController active UINavigationController if present
    ///     - Parameter sourceController the currently visible view controller
    ///     - Parameter destinationController the controller to present
    case custom(
        navigationHandler: CustomNavigationHandler
    )
}

public enum RootType{
    /// Instantiate a simple UINavigationController as Root and set the controller as first controller
    case singleStack(
        controller: UIViewController,
        customStack: UINavigationController? = nil
    )
    
    /// Instantiate a simple UITabBarController with a single navigation stack as Root
    case singleStackTabBar(
        tabBarInfoProvider: TabBarInfoProvider,
        customTabBarController: UITabBarController? = nil,
        customStack: UINavigationController? = nil
    )
    
    /// Instantiate UITabBarController as Root with a different navigation stack for each Tab
    case multiStackTabBar(
        tabBarInfoProvider: TabBarInfoProvider,
        customTabBarController: UITabBarController? = nil,
        customStackFactory: (() -> UINavigationController)? = nil
    )
    
    case custom(rootController: IRootController & UIViewController)
    
    fileprivate var isTabBar: Bool{
        switch self {
        case .singleStackTabBar, .multiStackTabBar: return true
        default: return false
        }
    }
}

public protocol IAppNavigator: AnyObject{
    
    var window: UIWindow! { get }
    
    var root: IRootController! { get set }

    /// Set the root view controller chosing among a predefined configurations
    func setRootController(rootType: RootType, animated: Bool)
    
    /// Create a new route from a source controller towards a destination controller using the selected presentation type
    func go(to: UIViewController, presentationType: PresentationType)
    
    
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
        let root: IRootController & UIViewController
        
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
            
        case .custom(let rootController):
            root = rootController
            
        }
        
        self.root = root
        window.rootViewController = root
        window.makeKeyAndVisible()
    }

    
    func go(
        to: UIViewController,
        presentationType: PresentationType = .push()
    ){
        
        
        switch presentationType {

        case .push(let animated, let completion):
            guard let navCon = window.topViewController?.navigationController else {
                fatalError("Navigation Controller not found in hierarchy")
            }
            
            navCon.pushViewController(to, animated: animated, completion: completion)
            
        case .pushReplace(let animated, let completion):
            
            guard let navCon = window.topViewController?.navigationController else {
                fatalError("Navigation Controller not found in hierarchy")
            }
            
            let controllersCount = navCon.viewControllers.count
            var excludingLastController = Array(navCon.viewControllers[0..<controllersCount-1])
            excludingLastController.append(to)
            navCon.setViewControllers([], animated: animated)
            
            completion?()
            
        case .present(let animated, let completion):
            guard let topVc = window.topViewController else {
                fatalError("Top Vc not found")
            }
            topVc.present(to, animated: animated, completion: completion)
            
        case .presentWithNavigation(let animated, let completion, let customStack):
            
            guard let topVc = window.topViewController else {
                fatalError("Top Vc not found")
            }
            
            let newNavCon = customStack ?? .init()
            
            newNavCon.viewControllers = [to]
            
            topVc.present(newNavCon, animated: animated, completion: completion)
            
        case .bottomSheet(
            let animated,
            let completion,
            let desiredHeight
        ):
            guard let topVc = window.topViewController else {
                fatalError("Top Vc not found")
            }
            
            topVc.presentInBottomSheetController(to, withHeight: desiredHeight, animated: animated)
            
            completion?()
            
        case .bottomSheetWithNavigation(
            let animated,
            let completion,
            let desiredHeight,
            let customStack
        ):
            
            guard let topVc = window.topViewController else {
                fatalError("Top Vc not found")
            }
            
            let newNavCon = customStack ?? .init()
            
            newNavCon.viewControllers = [to]
            
            topVc.presentInBottomSheetController(newNavCon, withHeight: desiredHeight, animated: animated)
            
            completion?()
            
        case .custom(let handler):
            guard let topVc = window.topViewController else {
                fatalError("Top Vc not found")
            }
            handler(root.activeNavCon, topVc, to)
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
