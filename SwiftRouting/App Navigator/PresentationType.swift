//
//  PresentationType.swift
//  SwiftRouting
//
//  Created by Lorenzo Limoli on 15/07/22.
//

import UIKit

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
