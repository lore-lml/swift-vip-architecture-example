//
//  HPService.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 23/06/22.
//

import Foundation

protocol HPService{
    init(hpRepository: HPRepository)
    
    func getAllCharacters(completion: @escaping HPResult<[DtoHpCharacter]>)
    
    func getStudents(completion: @escaping HPResult<[DtoHpCharacter]>)
    
    func getStaff(completion: @escaping HPResult<[DtoHpCharacter]>)
    
    func getImageOf(character: DtoHpCharacter, completion: @escaping HPResult<Data>)
    
    func getCharactersOf(house: HPHouse, completion: @escaping HPResult<[DtoHpCharacter]>)
    
    func getCharacterDetail(character: DtoHpCharacter) -> DtoHpCharacterDetail
}
