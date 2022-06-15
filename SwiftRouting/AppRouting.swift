//
//  AppRouting.swift
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

public protocol AppRouting: AnyObject{
    
    static var instance: AppRouting { get }
    
    var window: UIWindow? { get set }
    
    func navigationControllerFactory(rootController: UIViewController) -> UINavigationController
    
    @discardableResult
    func setRootController<T: RoutedController>(ofType type: T.Type, presentationInput: T.PresentationInput?, animated: Bool) -> Bool
    
    func go<From: RoutedController, To: RoutedController>(from: From, to: To.Type, input: To.PresentationInput?, presentationType: PresentationType, completion: (() -> Void)?, animated: Bool)
    
    func back<From: RoutedController>(from: From, completion: (() -> Void)?, animated: Bool)
    
    func back<From: RoutedController, To: RoutedController>(from: From, to: To, completion: (() -> Void)?, animated: Bool)
    
    @discardableResult
    func back<From: RoutedController, To: RoutedController>(from: From, to type: To.Type, completion: (() -> Void)?, animated: Bool) -> Bool
    
    func dismiss<T: RoutedController>(_ controller: T, completion: (() -> Void)?, animated: Bool)
}

public extension AppRouting{
    
    func navigationControllerFactory(rootController: UIViewController) -> UINavigationController{
        return .init(rootViewController: rootController)
    }
    
    @discardableResult
    func setRootController<T: RoutedController>(ofType type: T.Type, presentationInput: T.PresentationInput? = nil, animated: Bool = true) -> Bool{
        
        guard let window = self.window else { return false }
        
        let destinationController = createController(type: type)
        
        destinationController.presentationInput = presentationInput
        
        if let navCon = window.rootViewController as? UINavigationController{
            navCon.setViewControllers([destinationController], animated: animated)
            return true
        }
        
        window.rootViewController = navigationControllerFactory(rootController: destinationController)
        
        window.makeKeyAndVisible()
        
        return true
    }
    
    func go<From: RoutedController, To: RoutedController>(
        from: From,
        to: To.Type,
        input: To.PresentationInput? = nil,
        presentationType: PresentationType = .push,
        completion: (() -> Void)? = nil,
        animated: Bool = true
    ){
        
        let destinationController = createController(type: to)
        destinationController.presentationInput = input
        
        switch presentationType {
        case .push:
            guard let navCon = from.navigationController else {
                fatalError("Cannot find navigation controller. Please use one as root to push new controllers")
            }
            
            navCon.pushViewController(destinationController, animated: animated)
            
            completion?()
            
        case .pushReplace:
            
            guard let navCon = from.navigationController else {
                fatalError("Cannot find navigation controller. Please use one as root to push new controllers")
            }
            
            let controllersCount = navCon.viewControllers.count
            var excludingLastController = Array(navCon.viewControllers[0..<controllersCount-1])
            excludingLastController.append(destinationController)
            navCon.setViewControllers([], animated: animated)
            
            completion?()
            
        case .present:
            
            from.present(destinationController, animated: animated, completion: completion)
            
        case .presentWithNavigation:
            
            let newNavCon = navigationControllerFactory(rootController: destinationController)
            
            from.present(newNavCon, animated: animated, completion: completion)
        }
    }
    
    func back<From: RoutedController>(from: From, completion: (() -> Void)? = nil, animated: Bool = true){
        
        guard let navCon = from.navigationController else {
            fatalError("Cannot find navigation controller. Please use one as root to push new controllers")
        }
        
        navCon.popViewController(animated: true)
        completion?()
        
    }
    
    func back<From: RoutedController, To: RoutedController>(from: From, to: To, completion: (() -> Void)? = nil, animated: Bool = true){
        
        guard let navCon = from.navigationController else {
            fatalError("Cannot find navigation controller. Please use one as root to push new controllers")
        }
        
        navCon.popToViewController(to, animated: animated)
        completion?()
    }
    
    @discardableResult
    func back<From: RoutedController, To: RoutedController>(from: From, to: To.Type, completion: (() -> Void)? = nil, animated: Bool = true) -> Bool{
        
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
    
    func dismiss<T: RoutedController>(_ controller: T, completion: (() -> Void)? = nil, animated: Bool = true){
        controller.dismiss(animated: animated, completion: completion)
    }
}

private func createController<T: RoutedController>(type: T.Type) -> T{
    
    let destinationController: UIViewController
    
    if let xibImportable = toXibImportable(type: type){
        destinationController = xibImportable.loadFromXib()
        
    }else if let storyboardImportable = toStoryboardImportable(type: type){
        destinationController = storyboardImportable.instantiate()
        
    }else{
        destinationController = type.init()
    }
    
    return destinationController as! T
}


private func toXibImportable<T: RoutedController>(type: T.Type) -> XibImportable.Type?{
    
    type.self as? XibImportable.Type
}

private func toStoryboardImportable<T: RoutedController>(type: T.Type) -> StoryboardImportable.Type?{
    
    type.self as? StoryboardImportable.Type
}


private func getController<T: RoutedController>(navCon: UINavigationController, type: T.Type) -> UIViewController{
    
    navCon.viewControllers.last(where: { $0 is T })!
}
