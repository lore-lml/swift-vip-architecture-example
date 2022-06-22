//
//  HomeScenePresenter.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 21/06/22.
//

import Foundation

// MARK: Response to ViewModel methods mappers
protocol IHomeScenePresenter{
    
}

class HomeScenePresenter: IHomeScenePresenter{
    weak var view: IHomeSceneDelegate?
    
    init(view: IHomeSceneDelegate){
        self.view = view
    }
    
}
