//
//  BaseRouter.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 21/06/22.
//

import UIKit
import Swinject
import SwiftRouting

enum BaseRoutes{
    case home
}

class BaseRouter: IRouter{
    
    typealias Routes = BaseRoutes
    
    private(set) var navigator: IAppNavigator?
    private(set) var assembler: Assembler?
    
    
    init(_ router: IAppNavigator, assembler: Assembler?){
        self.navigator = router
        self.assembler = assembler
    }
    
    func showRoute(route: BaseRoutes){
        switch route {
        case .home:
            let rootType: RootType = .multiStackTabBar(tabBarInfoProvider: TabBarInfo(assembler: assembler))
            navigator!.setRootController(rootType: rootType)
        }
    }
    
}
