//
//  CharacterDetailSceneInteractor.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 27/06/22.
//  Copyright (c) 2022 Lorenzo Limoli. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates
//  https://github.com/lore-lml

import Foundation

// MARK: Interactor Requests interface
protocol ICharacterDetailSceneInteractor: AnyObject{
    
}

class CharacterDetailSceneInteractor {
    
    var presenter: ICharacterDetailScenePresenter
    
    /*
     var worker1: Worker1
     var worker2: Worker2
     */
    
    init(presenter: ICharacterDetailScenePresenter /*, dependency1: Dependency1, dependency2: Dependency2 */){
        self.presenter = presenter
        /*
         self.worker1 = Worker1(dependency1)
         self.worker2 = Worker2(dependency2)
         */
    }

}

extension CharacterDetailSceneInteractor: ICharacterDetailSceneInteractor{
    // MARK: BUSINESS LOGIC INTERFACE IMPLEMENTATIONS
}
