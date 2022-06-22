//
//  HomeAdapter.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 21/06/22.
//

import Swinject
import SwiftRouting

class HomeAdapter: IAdapter{
    
    typealias Input = String
    
    static func setup(input: String, assembler: Assembler? = nil) -> UIViewController{
        
        guard let assembler = assembler,
              let appRouter = assembler.resolver.resolve(IAppRouter.self)
        else {
            fatalError("Dependencies not found")
        }
        
        let newAssembler = Assembler(parentAssembler: assembler)
        
        let controller = HomeViewController()
        let router = HomeRouter(view: controller)
        let presenter = HomePresenter(view: controller)
        let interactor = HomeInteractor(presenter: presenter)
        
        controller.router = router
        controller.interactor = interactor
        
        router.assembler = newAssembler
        router.appRouter = appRouter
        
        interactor.input = input
        
        return controller
    }
}
