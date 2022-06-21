//
//  Extension+UINavigationController.swift
//  SwiftRouting
//
//  Created by Lorenzo Limoli on 21/06/22.
//


import UIKit

extension UINavigationController {
    func pushViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        pushViewController(viewController, animated: animated)
        
        guard let completion = completion else {
            return
        }

        if let coordinator = transitionCoordinator, animated {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }

    func popViewController(animated: Bool, completion: (() -> Void)?) {
        popViewController(animated: animated)
        
        guard let completion = completion else {
            return
        }

        if let coordinator = transitionCoordinator, animated {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }

    func popToViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        popToViewController(viewController, animated: animated)
        
        guard let completion = completion else {
            return
        }

        if let coordinator = transitionCoordinator, animated {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }

    func popToRootViewController(animated: Bool, completion: (() -> Void)?) {
        popToRootViewController(animated: true)
        
        guard let completion = completion else {
            return
        }

        if let coordinator = transitionCoordinator, animated {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
}
