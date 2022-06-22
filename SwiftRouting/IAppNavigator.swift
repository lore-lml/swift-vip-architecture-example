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

public protocol IAppNavigator: AnyObject{
    
    var window: UIWindow! { get set }

    func setRootController(_ controller: UIViewController, animated: Bool)
    

    func go(from: UIViewController, to: UIViewController, presentationType: PresentationType, completion: (() -> Void)?, animated: Bool)
    
    
    func back(from: UIViewController, to: UIViewController, completion: (() -> Void)?, animated: Bool)
    
    @discardableResult
    func back<To: UIViewController>(from: UIViewController, to type: To.Type, completion: (() -> Void)?, animated: Bool) -> Bool
    
    
    func dismiss(_ controller: UIViewController, completion: (() -> Void)?, animated: Bool)
}

public extension IAppNavigator{
    
    func setRootController(_ controller: UIViewController, animated: Bool = true){
        
        if let navCon = window.rootViewController as? UINavigationController{
            navCon.setViewControllers([controller], animated: animated)
            return
        }
        
        window.rootViewController = UINavigationController(rootViewController: controller)
        
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
