//
//  DefaultAppNavigator.swift
//  SwiftRouting
//
//  Created by Lorenzo Limoli on 15/07/22.
//

import UIKit

open class DefaultAppNavigator: IAppNavigator{
    
    public private(set) var window: UIWindow
    
    public init(window: UIWindow){
        self.window = window
    }
    
}
