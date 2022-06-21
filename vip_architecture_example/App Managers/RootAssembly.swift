//
//  RootAssembler.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 22/06/22.
//

import Swinject
import SwiftRouting

class RootAssembly: Assembly{
    
    weak var window: UIWindow!
    
    init(window: UIWindow){
        self.window = window
    }
    
    func assemble(container: Container) {
        
        container.register(IAppRouter.self) { _ in
            AppRouter.initialize(window: self.window)
            return AppRouter.shared
        }
        
    }
    
    
}
