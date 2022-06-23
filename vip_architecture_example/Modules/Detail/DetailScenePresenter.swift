//
//  DetailScenePresenter.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 21/06/22.
//

import Foundation

// MARK: Response to ViewModel methods mappers
protocol IDetailScenePresenter: AnyObject{
    
}

class DetailScenePresenter: IDetailScenePresenter{
    weak var view: IDetailSceneDelegate?
    
    init(view: IDetailSceneDelegate){
        self.view = view
    }
    

}
