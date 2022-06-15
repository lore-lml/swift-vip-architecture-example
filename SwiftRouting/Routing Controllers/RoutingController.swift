//
//  RoutingController.swift
//  SwiftRouting
//
//  Created by Lorenzo Limoli on 15/06/22.
//

import UIKit

public protocol RoutedController: UIViewController{
    associatedtype PresentationInput: Any
    
    var presentationInput: PresentationInput? { get set }
}


public extension RoutedController where PresentationInput == Void{
    var presentationInput: PresentationInput?{
        get{ nil }
        set{}
    }
}
