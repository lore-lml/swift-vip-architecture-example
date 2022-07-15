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
    
    func getCharactersOf(house: HpHouse, completion: @escaping HPResult<[DtoHpCharacter]>)
    
    func getCharacterDetail(character: DtoHpCharacter) -> DtoHpCharacterDetail
}
