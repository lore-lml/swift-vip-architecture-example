//
//  BottomSheetExample.swift
//  CBUAEApp
//
//  Created by Lorenzo Limoli on 05/01/22.
//

import Foundation


import UIKit

public class BottomSheetPresentationController: UIPresentationController{
    
    let blurEffectView: UIView
    var tapGestureRecognizer: UITapGestureRecognizer!
    
    let startAlpha: CGFloat = 0
    let endAlpha: CGFloat = 0.5
    
    public var frameHeight: CGFloat!
    
    
    public override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        
        self.blurEffectView = UIView()
        
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismiss))
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurEffectView.isUserInteractionEnabled = true
        self.blurEffectView.addGestureRecognizer(tapGestureRecognizer)
        self.blurEffectView.backgroundColor = .black
    }
    
    public override var frameOfPresentedViewInContainerView: CGRect{
        
        let width = self.containerView!.frame.width
        let defaultHeight = self.containerView!.frame.height/2
        
        frameHeight = (frameHeight == nil) ? defaultHeight : frameHeight
        
        let height = UIScreen.main.bounds.maxY - frameHeight
        
        return CGRect(origin: CGPoint(x: 0, y: height + 12.0), size: CGSize(width: width, height: frameHeight))
    }
    
    public override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            self.blurEffectView.alpha = self.startAlpha
        }, completion: { (UIViewControllerTransitionCoordinatorContext) in
            self.blurEffectView.removeFromSuperview()
        })
    }
    
    public override func presentationTransitionWillBegin() {
        self.blurEffectView.alpha = startAlpha
        self.containerView?.addSubview(blurEffectView)
        self.presentedViewController.transitionCoordinator?.animate{ UIViewControllerTransitionCoordinatorContext in
            self.blurEffectView.alpha = self.endAlpha
        }
    }
    
    public override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView!.layer.masksToBounds = true
    }
    
    public override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        self.presentedView?.frame = frameOfPresentedViewInContainerView
        blurEffectView.frame = containerView!.bounds
    }
    
    @objc func dismiss(){
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
}
