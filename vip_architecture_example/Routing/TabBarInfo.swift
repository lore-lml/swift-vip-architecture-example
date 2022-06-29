//
//  TabBarInfo.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 27/06/22.
//

import Swinject
import SwiftRouting
import UIKit

class TabBarInfo: TabBarInfoProvider{
    
    private(set) var itemsInfo: [TabBarItemInfo]
    
    init(assembler: Assembler?){
        itemsInfo = [
            .init(viewController: CharacterListSceneAdapter.setup(input: .students, assembler: assembler), tabBarItem: .init(
                    title: "Students",
                    image: .init(systemName: "person"),
                    selectedImage: .init(systemName: "person.fill")
                )
            ),
            
                .init(viewController: CharacterListSceneAdapter.setup(input: .staff, assembler: assembler), tabBarItem: .init(
                    title: "Staff",
                    image: .init(systemName: "book"),
                    selectedImage: .init(systemName: "book.fill")
                )
            ),
        
                .init(viewController: HousesSceneAdapter.setup(assembler: assembler), tabBarItem: .init(
                    title: "Houses",
                    image: .init(systemName: "house"),
                    selectedImage: .init(systemName: "house.fill")
                )
            ),
        ]
    }
}
