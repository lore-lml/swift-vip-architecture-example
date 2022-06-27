//
//  DtoHPCharacter.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 23/06/22.
//

import Foundation

protocol DtoHpCharacter: Codable{
    var name: String { get }
    var house: HPHouse { get }
    var image: String { get }
}

extension HPCharacter: DtoHpCharacter{}
