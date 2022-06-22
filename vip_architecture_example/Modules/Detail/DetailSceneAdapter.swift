//
//  DetailSceneAdapter.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 21/06/22.
//

import Swinject
import SwiftRouting

class DetailSceneAdapter: IAdapter{
    
    typealias Input = String
    
    static func setup(input: String? = nil, assembler: Assembler? = nil) -> UIViewController{
        
        guard let assembler = assembler,
              let navigator = assembler.resolver.resolve(IAppNavigator.self)
            // Add more dependency here
        else {
            fatalError("Dependencies not found")
        }
        
        let newAssembler = Assembler(parentAssembler: assembler)
        
        let controller = DetailSceneViewController()
        let router = DetailSceneRouter(view: controller)
        let presenter = DetailScenePresenter(view: controller)
        let interactor = DetailSceneInteractor(presenter: presenter)
        
        controller.router = router
        controller.interactor = interactor
        controller.input = input
        
        router.assembler = newAssembler
        router.navigator = navigator
        
        return controller
    }
}
