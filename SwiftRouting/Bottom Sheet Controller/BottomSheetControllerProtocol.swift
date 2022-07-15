//
//  BottomSheetControllerProtocol.swift
//  CBUAEApp
//
//  Created by Lorenzo Limoli on 10/01/22.
//

import UIKit


public protocol BottomSheetControllerProtocol: XibImportable{
    var frameHeight: CGFloat? { get set }
    var containerSubview: UIView? { get set }
    
    static func fromXib() -> Self
}

extension BottomSheetControllerProtocol where Self: BottomSheetViewController{
    
    func addViewToContainer(_ view: UIView){
        view.frame = containerView.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true

        containerView.addSubview(view)
    }
    
}


