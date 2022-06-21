//
//  DetailAdapter.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 21/06/22.
//

import Swinject
import SwiftRouting

class DetailAdapter: IAdapter{
    
    typealias Input = String
    
    static func setup(input: String, assembler: Assembler? = nil) -> UIViewController{
        
        let controller = DetailViewController()
        let router = DetailRouter(view: controller)
        let presenter = DetailPresenter(view: controller)
        let interactor = DetailInteractor(presenter: presenter)
        
        controller.router = router
        controller.interactor = interactor
        interactor.input = input
        
        return controller
    }
}
