//
//  BottomSheetViewController.swift
//  SwiftRouting
//
//  Created by Lorenzo Limoli on 15/07/22.
//

import UIKit

public class BottomSheetViewController: UIViewController, BottomSheetControllerProtocol {
    
    
    public var frameHeight: CGFloat?
    public var containerSubview: UIView?
    
    @IBOutlet weak var swipeDownArea: UIView!
    @IBOutlet weak var swipeDownIndicator: UIView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var indicatorContainer: UIView!
    
    lazy var defaultFrameHeight: CGFloat = {
        view.frame.height
    }()
    
    lazy var dismissibleHeight: CGFloat = {
        defaultFrameHeight / 2.5
    }()
    
    // keep updated with new height
    lazy var currentContainerHeight: CGFloat = {
        defaultFrameHeight
    }()
    
    private var dismissCompletion: (() -> Void)?
    
    @discardableResult
    func withDismissHandler(_ handler: (() -> Void)?) -> Self{
        dismissCompletion = handler
        return self
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeDownArea.layer.cornerRadius = 15
        swipeDownIndicator.layer.cornerRadius = 4
        
        if let containerSubview = containerSubview {
            addViewToContainer(containerSubview)
        }
        
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didSwipeDownView(_:)))
        indicatorContainer.addGestureRecognizer(panGesture)
    }

}

extension BottomSheetViewController{
    
    override public func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        guard let completion = completion else {
            super.dismiss(animated: flag, completion: dismissCompletion)
            return
        }

        super.dismiss(animated: flag, completion: completion)
        dismissCompletion?()
    }
    
    func dismiss(){
        self.dismiss(animated: true, completion: dismissCompletion)
    }
    
    @objc func didSwipeDownView(_ sender: UIPanGestureRecognizer){
        let translation = sender.translation(in: indicatorContainer)

        
        let newHeight = currentContainerHeight - translation.y

        // Handle based on gesture state
        switch sender.state {
        case .changed:
            // This state will occur when user is dragging
            if newHeight < defaultFrameHeight {
                updatePresentedViewHeight(newHeight)
            }
        case .ended:
            // This happens when user stop drag,
            // so we will get the last height of container
            // Condition 1: If new height is below min, dismiss controller
            if newHeight < (dismissibleHeight + topConstraint.constant) {
                dismiss()
            }
            else{
                animateContainerHeight(defaultFrameHeight)
            }

        default:
            break
        }
    }
    
    func updatePresentedViewHeight(_ height: CGFloat){
        topConstraint.constant = defaultFrameHeight - height
    }
    
    func animateContainerHeight(_ height: CGFloat) {
        updatePresentedViewHeight(height)
        currentContainerHeight = height
        
        UIView.animate(withDuration: 0.3){ [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
}


extension BottomSheetViewController: UIViewControllerTransitioningDelegate{
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = BottomSheetPresentationController(presentedViewController: presented, presenting: presenting)
        
        if let operationBottomSheet = presented as? BottomSheetViewController{
            presentationController.frameHeight = operationBottomSheet.frameHeight
        }
        
        return presentationController
    }
}
