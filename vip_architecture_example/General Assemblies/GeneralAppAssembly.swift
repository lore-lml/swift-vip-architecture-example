//
//  RootAssembler.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 22/06/22.
//

import Swinject
import SwiftRouting

class GeneralAppAssembly: Assembly{
    
    weak var window: UIWindow!
    
    init(window: UIWindow){
        self.window = window
    }
    
    func assemble(container: Container) {
        
        container.register(IAppNavigator.self) { _ in
            AppNavigator.initialize(window: self.window)
            return AppNavigator.shared
        }.inObjectScope(.container)
        
    }
    
}