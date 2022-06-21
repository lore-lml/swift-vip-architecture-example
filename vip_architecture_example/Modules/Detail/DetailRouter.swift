//
//  DetailRouter.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 21/06/22.
//

import UIKit
import SwiftRouting
import Swinject

typealias IDetailControllerProtocol = IDetailDelegate & UIViewController

// MARK: Navigation Methods
protocol IDetailRouter: AnyObject{
    
}

class DetailRouter: IDetailRouter, IRouter{
    
    typealias Routes = Void
    
    weak var view: IDetailControllerProtocol?
    var appRouter: IAppRouter?
    var assembler: Assembler?
    
    init(view: IDetailControllerProtocol) {
        self.view = view
    }
}

