//
//  RootType.swift
//  SwiftRouting
//
//  Created by Lorenzo Limoli on 15/07/22.
//

import UIKit

public typealias CustomNavigationHandler = (UINavigationController?, UIViewController?, UIViewController) -> Void

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
    
    case custom(rootController: UIViewController)
}
