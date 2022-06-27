//
//  HPRepository.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 23/06/22.
//

import Foundation

protocol HPRepository{
    func getAllCharacters(completion: @escaping HPResult<[HPCharacter]>)
    
    func getStudents(completion: @escaping HPResult<[HPCharacter]>)
    
    func getStaff(completion: @escaping HPResult<[HPCharacter]>)
    
    func getCharactersOf(house: HPHouse, completion: @escaping HPResult<[HPCharacter]>)
}
