//
//  Extension+UIViewController.swift
//  SwiftRouting
//
//  Created by Lorenzo Limoli on 05/07/22.
//

import UIKit

extension UIViewController {

    var isModal: Bool {

        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController

        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
    
    func presentInBottomSheetController(_ vc: UIViewController, withHeight height: CGFloat? = nil, animated: Bool = true, dismissCompletion: (() -> Void)? = nil ){
        let bottomSheetController = BottomSheetViewController.fromXib()
            .withDismissHandler(dismissCompletion)
        
        bottomSheetController.modalPresentationStyle = .custom
        // This is possible because transitioningDelegate is a weak property. This avoid memory cycles
        bottomSheetController.transitioningDelegate = bottomSheetController
        
        bottomSheetController.addChild(vc)
        bottomSheetController.frameHeight = height
        bottomSheetController.containerSubview = vc.view
        
        vc.didMove(toParent: self)
        present(bottomSheetController, animated: animated)
    }
}
