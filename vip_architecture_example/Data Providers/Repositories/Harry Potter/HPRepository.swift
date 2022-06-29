//
//  HPRepository.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 23/06/22.
//

import Foundation

protocol HPRepository{
    func getAllCharacters(completion: @escaping HPResult<[HpCharacter]>)
    
    func getStudents(completion: @escaping HPResult<[HpCharacter]>)
    
    func getStaff(completion: @escaping HPResult<[HpCharacter]>)
    
    func getCharactersOf(house: HpHouse, completion: @escaping HPResult<[HpCharacter]>)
    
    func getImageOf(character: HpCharacter, completion: @escaping HPResult<Data>)
}
