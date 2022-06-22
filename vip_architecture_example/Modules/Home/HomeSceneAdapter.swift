//
//  HomeAdapter.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 21/06/22.
//

import Swinject
import SwiftRouting

class HomeSceneAdapter: IAdapter{
    
    typealias Input = String
    
    static func setup(input: String? = nil, assembler: Assembler? = nil) -> UIViewController{
        
        guard let assembler = assembler,
              let navigator = assembler.resolver.resolve(IAppNavigator.self)
            // Add more dependency here
        else {
            fatalError("Dependencies not found")
        }
        
        let newAssembler = Assembler(parentAssembler: assembler)
        
        let controller = HomeSceneViewController()
        let router = HomeSceneRouter(view: controller)
        let presenter = HomeScenePresenter(view: controller)
        let interactor = HomeSceneInteractor(presenter: presenter)
        
        controller.router = router
        controller.interactor = interactor
        controller.input = input
        
        router.assembler = newAssembler
        router.navigator = navigator
        
        return controller
    }
}
