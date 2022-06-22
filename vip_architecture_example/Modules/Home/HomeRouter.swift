//
//  HomeRouter.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 21/06/22.
//

import UIKit
import SwiftRouting
import Swinject

typealias IHomeController = IHomeDelegate & UIViewController

// MARK: Navigation Methods
protocol IHomeRouter: AnyObject{
    func goToDetail(input: DetailSceneInput)
}

enum HomeRoutes{
    case detail(input: DetailAdapter.Input, assembler: Assembler?)
}

class HomeRouter: IHomeRouter, IRouter{
    
    typealias Routes = HomeRoutes
    
    weak var view: IHomeController!
    var appRouter: IAppRouter?
    var assembler: Assembler?
    
    init(view: IHomeController) {
        self.view = view
    }
    
    func showRoute(route: HomeRoutes) {
        switch route {
        case .detail(let input, let assembler):
            let controller = DetailAdapter.setup(input: input, assembler: assembler)
            appRouter?.go(from: view, to: controller)
        }
    }
    
    func goToDetail(input: DetailSceneInput){
        showRoute(route: .detail(input: input.input, assembler: assembler))
    }
}

