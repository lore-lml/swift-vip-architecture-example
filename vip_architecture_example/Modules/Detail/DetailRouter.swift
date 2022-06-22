//
//  DetailRouter.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 21/06/22.
//

import UIKit
import SwiftRouting
import Swinject

typealias IDetailController = IDetailDelegate & UIViewController

// MARK: Navigation Methods
protocol IDetailRouter: AnyObject{
    
}

class DetailRouter: IDetailRouter, IRouter{
    
    typealias Routes = Void
    
    weak var view: IDetailController!
    var appRouter: IAppRouter?
    var assembler: Assembler?
    
    init(view: IDetailController) {
        self.view = view
    }
}

