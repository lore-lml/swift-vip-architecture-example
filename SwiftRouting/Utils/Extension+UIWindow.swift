//
//  Extension+UIWindow.swift
//  SwiftRouting
//
//  Created by Lorenzo Limoli on 14/07/22.
//

import UIKit

extension UIWindow {
    var topViewController: UIViewController? {
        var top = self.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}
