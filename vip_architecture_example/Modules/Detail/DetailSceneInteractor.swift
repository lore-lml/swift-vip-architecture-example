//
//  DetailInteractor.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 21/06/22.
//

import Foundation

// MARK: Interactor Requests interface
protocol IDetailSceneInteractor: AnyObject{
    
}

class DetailSceneInteractor: IDetailSceneInteractor{
    
    var presenter: IDetailScenePresenter
    /*
     var worker1: Worker1
     var worker2: Worker2
     */
    
    init(presenter: IDetailScenePresenter /*, dependency1: Dependency1, dependency2: Dependency2 */){
        self.presenter = presenter
        /*
         self.worker1 = Worker1(dependency1)
         self.worker2 = Worker2(dependency2)
         */
    }
    
}
