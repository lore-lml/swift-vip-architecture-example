//
//  RoutingNavigationController.swift
//  SwiftRouting
//
//  Created by Lorenzo Limoli on 15/06/22.
//

import UIKit

public protocol RoutedNavigationController: UINavigationController{}

open class RoutingNavigationController: UINavigationController, RoutedNavigationController, RoutedController {
    
    public var presentationInput: Void?
    
    public typealias PresentationInput = Void

}
