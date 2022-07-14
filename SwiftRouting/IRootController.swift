//
//  IRootController.swift
//  SwiftRouting
//
//  Created by Lorenzo Limoli on 14/07/22.
//

import UIKit

public protocol IRootController: AnyObject{
    /// Represents the UINavigationController of the last visible controller pushed in a navigation stack. If nil, push or pushReplace presentation type cannot be performed
    var activeNavCon: UINavigationController? { get }
}

extension UINavigationController: IRootController{
    public var activeNavCon: UINavigationController? { self }
}

extension UITabBarController: IRootController{
    public var activeNavCon: UINavigationController?{
        
        if let navCon = self.selectedViewController as? UINavigationController{
            return navCon
        }
        
        return self.navigationController
    }
}
