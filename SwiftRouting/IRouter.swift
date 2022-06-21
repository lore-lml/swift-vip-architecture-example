//
//  IRouter.swift
//  SwiftRouting
//
//  Created by Lorenzo Limoli on 22/06/22.
//

import Swinject

public protocol IRouter: AnyObject{
    associatedtype Routes
    
    var appRouter: IAppRouter? { get }
    var assembler: Assembler? { get }
    
    func showRoute(route: Routes)
}

public extension IRouter{
    var assembler: Assembler?{ nil }
}

public extension IRouter where Routes == Void{
    func showRoute(route: Routes){}
}
