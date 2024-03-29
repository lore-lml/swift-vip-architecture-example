//
//  DtoHpCharacterDetail.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 23/06/22.
//

import Foundation

protocol DtoHpCharacterDetail: DtoHpCharacter{
    var name: String { get }
    var species: String { get }
    var gender: String { get }
    var house: HpHouse { get }
    var dateOfBirth: String { get }
    var wizard: Bool { get }
    var ancestry: String { get }
    var eyeColour: String { get }
    var hairColour: String { get }
    var alive: Bool { get }
    var image: String { get }
    var wand: HPWand { get }
}

extension HpCharacter: DtoHpCharacterDetail{}
