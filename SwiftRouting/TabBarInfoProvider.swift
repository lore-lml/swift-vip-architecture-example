//
//  TabBarInfoProvider.swift
//  SwiftRouting
//
//  Created by Lorenzo Limoli on 23/06/22.
//

import UIKit

public struct TabBarItemInfo{
    public init(viewController: @autoclosure @escaping () -> UIViewController, tabBarItem: UITabBarItem) {
        
        self.viewController = viewController
        self.tabBarItem = tabBarItem
    }
    
    var viewController: () -> UIViewController
    var tabBarItem: UITabBarItem
    
}

public protocol TabBarInfoProvider{
    var itemsInfo: [TabBarItemInfo] { get }
}
