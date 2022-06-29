//
//  CharacterDetailSceneAdapter.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 27/06/22.
//  Copyright (c) 2022 Lorenzo Limoli. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates
//  https://github.com/lore-lml

import Swinject
import SwiftRouting

extension CharacterDetailSceneViewController: XibImportable{}

class CharacterDetailSceneAdapter {
    
    private init() {}
    
    // MARK: Dependency Injection
    static func setup(input: CharacterDetailSceneModels.Input? = nil, assembler: Assembler? = nil) -> UIViewController{
        
        guard let assembler = assembler,
              let navigator = assembler.resolver.resolve(IAppNavigator.self)
            // Add more dependency here
        else {
            fatalError("Dependencies not found")
        }
        
        let newAssembler = Assembler(parentAssembler: assembler)
        
        let controller = CharacterDetailSceneViewController.fromXib()
        let router = CharacterDetailSceneRouter(view: controller)
        let presenter = CharacterDetailScenePresenter(vc: controller)
        let interactor = CharacterDetailSceneInteractor(presenter: presenter)
        
        controller.router = router
        controller.interactor = interactor
        controller.input = input
        
        router.assembler = newAssembler
        router.navigator = navigator
        
        return controller
    }
}