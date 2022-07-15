//
//  DefaultAppNavigator.swift
//  SwiftRouting
//
//  Created by Lorenzo Limoli on 15/07/22.
//

import UIKit

open class DefaultAppNavigator: IAppNavigator{
    
    public weak var window: UIWindow!
    
    public var root: IRootController!
    
    public init(window: UIWindow){
        self.window = window
    }
    
}
