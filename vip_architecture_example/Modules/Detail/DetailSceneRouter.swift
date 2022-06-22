//
//  DetailSceneRouter.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 21/06/22.
//

import UIKit
import SwiftRouting
import Swinject

typealias IDetailSceneController = IDetailSceneDelegate & UIViewController

// MARK: Navigation Methods
protocol IDetailSceneRouter: AnyObject{
    
}

class DetailSceneRouter: IDetailSceneRouter, IRouter{
    
    typealias Routes = Void
    
    weak var view: IDetailSceneController!
    var navigator: IAppNavigator?
    var assembler: Assembler?
    
    init(view: IDetailSceneController) {
        self.view = view
    }
}

