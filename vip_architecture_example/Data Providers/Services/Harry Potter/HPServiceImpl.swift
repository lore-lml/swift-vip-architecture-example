//
//  HPServiceImpl.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 23/06/22.
//

import Foundation

class HPServiceImpl: HPService{
    
    private let _repo: HPRepository
    
    private var _allCharacters: [HPCharacter]?
    private var _studentsCharacters: [HPCharacter]?
    private var _staffCharacters: [HPCharacter]?
    private var _houseCharacters: [HPHouse: [HPCharacter]] = [:]
    
    required init(hpRepository: HPRepository) {
        self._repo = hpRepository
    }
    
    func getAllCharacters(completion: @escaping HPResult<[DtoHpCharacter]>){
        if let allCharacters = _allCharacters {
            completion(.success(allCharacters))
            return
        }
        
        self._repo.getAllCharacters{ res in
            completion(res.map{
                self._allCharacters = $0
                Log.d($0.jsonString!)
                return $0 as [DtoHpCharacter]
            })
        }
    }
    
    func getStudents(completion: @escaping HPResult<[DtoHpCharacter]>){
        if let studentsCharacters = _studentsCharacters {
            completion(.success(studentsCharacters))
            return
        }
        
        self._repo.getStudents{ res in
            completion(res.map{
                self._studentsCharacters = $0
                Log.d($0.jsonString!)
                return $0 as [DtoHpCharacter]
            })
        }
    }
    
    func getStaff(completion: @escaping HPResult<[DtoHpCharacter]>){
        if let staffCharacters = _staffCharacters {
            completion(.success(staffCharacters))
            return
        }
        
        self._repo.getStudents{ res in
            completion(res.map{
                self._staffCharacters = $0
                Log.d($0.jsonString!)
                return $0 as [DtoHpCharacter]
            })
        }
    }
    
    func getCharactersOf(house: HPHouse, completion: @escaping HPResult<[DtoHpCharacter]>){
        
        if let houseCharacters = _houseCharacters[house]{
            completion(.success(houseCharacters))
            return
        }
        
        self._repo.getStudents{ res in
            completion(res.map{
                self._houseCharacters[house] = $0
                Log.d($0.jsonString!)
                return $0 as [DtoHpCharacter]
            })
        }
    }
    
    func getCharacterDetail(character: DtoHpCharacter) -> DtoHPCharacterDetail{
        character as! DtoHPCharacterDetail
    }
}
