//
//  HpCharacter.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 23/06/22.
//

import Foundation

struct HpCharacter: Codable{
    var name: String
    var species: String
    var gender: String
    var house: HpHouse
    var dateOfBirth: String
    var wizard: Bool
    var ancestry: String
    var eyeColour: String
    var hairColour: String
    var alive: Bool
    var image: String
    var wand: HPWand
}

enum HpHouse: String, Codable{
    case gryffindor = "Gryffindor"
    case slytherin = "Slytherin"
    case hufflepuff = "Hufflepuff"
    case ravenclaw = "Ravenclaw"
    case none = ""
}


struct HPWand: Codable{
    var core: String
    var wood: String
}
