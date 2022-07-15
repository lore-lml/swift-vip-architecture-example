//
//  HPRepositoryImpl.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 23/06/22.
//

import Alamofire

typealias HPResult<T> = (Result<T, AFError>) -> Void

class HPRepositoryImpl: HPRepository{
    
    static let shared: HPRepositoryImpl = .init()
    
    private let _baseUrl = "https://hp-api.herokuapp.com/api/characters"
    
    private init(){}
    
    func getAllCharacters(completion: @escaping HPResult<[HpCharacter]>){
        request(route: "", completion: completion)
    }
    
    func getStudents(completion: @escaping HPResult<[HpCharacter]>){
        request(route: "students", completion: completion)
    }
    
    func getStaff(completion: @escaping HPResult<[HpCharacter]>){
        request(route: "staff", completion: completion)
    }
    
    func getCharactersOf(house: HpHouse, completion: @escaping HPResult<[HpCharacter]>){
        request(route: "house/\(house.rawValue)", completion: completion)
    }
    
    private func request(route: String, completion: @escaping HPResult<[HpCharacter]>){
        AF.request("\(_baseUrl)/\(route)")
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: [HpCharacter].self) { response in
                let mappedRes = response.result.map{
                    $0.map{ c in
                        c.copyWith(image: c.image.replacingOccurrences(of: "http", with: "https"))
                    }
                }
                completion(mappedRes)
            }
//            .responseData { response in
//                let decoder = JSONDecoder()
//
//                let newResponse = response.result.map{
//                    try! decoder.decode([HPCharacter].self, from: $0)
//                }
//
//                completion(newResponse)
//            }
    }
}


fileprivate extension HpCharacter{
    func copyWith(
        name: String? = nil,
        species: String? = nil,
        gender: String? = nil,
        house: HpHouse? = nil,
        dateOfBirth: String? = nil,
        wizard: Bool? = nil,
        ancestry: String? = nil,
        eyeColour: String? = nil,
        hairColour: String? = nil,
        alive: Bool? = nil,
        image: String? = nil,
        wand: HPWand? = nil
    ) -> HpCharacter{
        .init(
            name: name ?? self.name,
            species: species ?? self.species,
            gender: gender ?? self.species,
            house: house ?? self.house,
            dateOfBirth: dateOfBirth ?? self.dateOfBirth,
            wizard: wizard ?? self.wizard,
            ancestry: ancestry ?? self.ancestry,
            eyeColour: eyeColour ?? self.eyeColour,
            hairColour: hairColour ?? self.hairColour,
            alive: alive ?? self.alive,
            image: image ?? self.image,
            wand: wand ?? self.wand
        )
    }
}
