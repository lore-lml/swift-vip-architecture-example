//
//  CommonServiceAssembly.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 23/06/22.
//  Copyright (c) 2022 Lorenzo Limoli. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates
//  https://github.com/lore-lml

import Swinject


class CommonServiceAssembly: Assembly {
    
    func assemble(container: Container) {
        
        container.register(HPRepository.self) { _ in
            HPRepositoryImpl.shared
        }
        .inObjectScope(.container)
        
        
        container.register(HPService.self) { r in
            HPServiceImpl(hpRepository: r.resolve(HPRepository.self)!)
        }
        .inObjectScope(.container)
        
    }
}
