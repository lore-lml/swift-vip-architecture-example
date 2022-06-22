//
//  StartingRoutes.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 21/06/22.
//

import UIKit
import Swinject
import SwiftRouting

enum StartingRoutes{
    
    case register
    case login
    case home(input: String)

}

class StartingRouter: IRouter{
    
    typealias Routes = StartingRoutes
    
    private(set) var appRouter: IAppRouter?
    private(set) var assembler: Assembler?
    
    
    init(_ router: IAppRouter, assembler: Assembler){
        self.appRouter = router
        self.assembler = assembler
    }
    
    func showRoute(route: StartingRoutes){
        switch route {
        case .home(let input):
            let controller = HomeAdapter.setup(input: input, assembler: assembler)
            appRouter?.setRootController(controller)
        default:
            fatalError()
        }
    }
    
}
