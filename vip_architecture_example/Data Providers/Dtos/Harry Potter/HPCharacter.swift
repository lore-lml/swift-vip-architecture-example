//
//  HPCharacter.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 23/06/22.
//

import Foundation

struct HPCharacter: Codable{
    var name: String
    var species: String
    var gender: String
    var house: HPHouse
    var dateOfBirth: String
    var wizard: Bool
    var ancestry: String
    var eyeColour: String
    var hairColour: String
    var alive: Bool
    var image: String
    var wand: HPWand
}

struct HPWand: Codable{
    var core: String
    var wood: String
}
