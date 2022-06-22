//
//  AppNavigator.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 22/06/22.
//

import SwiftRouting
import UIKit


class AppNavigator: IAppNavigator{
    
    static var _navigator: AppNavigator?
    
    static var shared: AppNavigator{
        _navigator!
    }
    
    // Call this method before use the shared instance
    static func initialize(window: UIWindow){
        _navigator = AppNavigator(window: window)
    }
    
    weak var window: UIWindow!
    
    private init(window: UIWindow){
        self.window = window
    }
    
}
