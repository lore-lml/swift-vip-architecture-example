//
//  Extension+UIViewController.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 29/06/22.
//

import UIKit

extension UIView{
    var parentViewController: UIViewController? {
        // Starts from next (As we know self is not a UIViewController).
        var parentResponder: UIResponder? = self.next
        while parentResponder != nil {
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
            parentResponder = parentResponder?.next
        }
        return nil
    }
    
    @discardableResult
    func loadViewFromNib(into container: UIView? = nil) -> UIView? {
        
        let parent = container == nil ? self : container!
        
        let nibName = String(describing: type(of: self))
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else{
            return nil
        }
        
        view.frame = parent.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        parent.addSubview(view)
        
        return view
    }
}
