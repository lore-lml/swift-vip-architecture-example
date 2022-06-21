//
//  AppRouter.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 22/06/22.
//

import SwiftRouting
import UIKit


class AppRouter: IAppRouter{
    
    static var _appRouter: AppRouter?
    
    static var shared: AppRouter{
        _appRouter!
    }
    
    static func initialize(window: UIWindow){
        _appRouter = AppRouter(window: window)
    }
    
    weak var window: UIWindow!
    
    private init(window: UIWindow){
        self.window = window
    }
    
}
