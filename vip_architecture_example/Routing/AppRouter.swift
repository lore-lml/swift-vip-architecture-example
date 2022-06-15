//
//  AppRouter.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 15/06/22.
//


import SwiftRouting
import UIKit

class AppRouter: AppRouting{
    
    static var instance: AppRouting = AppRouter()
    
    weak var window: UIWindow?
    
    static func initialize(window: UIWindow?){
        instance.window = window
    }
    
    private init(){}
}
