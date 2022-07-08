//
//  HPServiceImpl.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 23/06/22.
//

import Foundation
import UIKit

class HPServiceImpl: HPService{
    
    private let _repo: HPRepository
    
    private var _allCharacters: [HpCharacter]?
    private var _studentsCharacters: [HpCharacter]?
    private var _staffCharacters: [HpCharacter]?
    private var _houseCharacters: [HpHouse: [HpCharacter]] = [:]
    private var _images: NSCache<NSString, NSData> = .init()
    
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
        
        self._repo.getStaff{ res in
            completion(res.map{
                self._staffCharacters = $0
                Log.d($0.jsonString!)
                return $0 as [DtoHpCharacter]
            })
        }
    }
    
    func getCharactersOf(house: HpHouse, completion: @escaping HPResult<[DtoHpCharacter]>){
        
        if let houseCharacters = _houseCharacters[house]{
            completion(.success(houseCharacters))
            return
        }
        
        self._repo.getCharactersOf(house: house){ res in
            completion(res.map{
                self._houseCharacters[house] = $0
                Log.d($0.jsonString!)
                return $0 as [DtoHpCharacter]
            })
        }
    }
    
    func getImageOf(character: DtoHpCharacter, completion: @escaping HPResult<Data>){
        if !character.image.isEmpty, let cachedImg = _images.object(forKey: .init(string: character.image)){
            completion(.success( cachedImg as Data ))
            return
        }
        
        self._repo.getImageOf(character: character as! HpCharacter) { res in
            completion(res.map{ $0 as Data })
        }
    }
    
    func getCharacterDetail(character: DtoHpCharacter) -> DtoHpCharacterDetail{
        character as! DtoHpCharacterDetail
    }
}
