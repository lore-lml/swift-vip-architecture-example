//
//  HomeSceneRouter.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 21/06/22.
//

import UIKit
import SwiftRouting
import Swinject

typealias IHomeSceneController = IHomeSceneDelegate & UIViewController

// MARK: Navigation Methods
protocol IHomeSceneRouter: AnyObject{
    func goToDetail(input: HomeSceneModels.DetailSceneInput)
}

enum HomeSceneRoutes{
    case detail(input: DetailSceneAdapter.Input, assembler: Assembler?)
}

class HomeSceneRouter: IHomeSceneRouter, IRouter{
    
    typealias Routes = HomeSceneRoutes
    
    weak var view: IHomeSceneController!
    var navigator: IAppNavigator?
    var assembler: Assembler?
    
    init(view: IHomeSceneController) {
        self.view = view
    }
    
    func showRoute(route: HomeSceneRoutes) {
        switch route {
        case .detail(let input, let assembler):
            let controller = DetailSceneAdapter.setup(input: input, assembler: assembler)
            navigator?.go(from: view, to: controller)
        }
    }
    
    func goToDetail(input: HomeSceneModels.DetailSceneInput){
        showRoute(route: .detail(input: input.input, assembler: assembler))
    }
}
