//
//  TabBarInfoProvider.swift
//  SwiftRouting
//
//  Created by Lorenzo Limoli on 23/06/22.
//

import UIKit

public struct TabBarItemInfo{
    var viewController: () -> UIViewController
    var tabBarItem: UITabBarItem
}

public protocol TabBarInfoProvider: AnyObject{
    var itemsInfo: [TabBarItemInfo] { get }
}
