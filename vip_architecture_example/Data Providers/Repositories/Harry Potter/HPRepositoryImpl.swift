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
    
    func getImageOf(character: HpCharacter, completion: @escaping HPResult<Data>){
        let url = character.image.replacingOccurrences(of: "http", with: "https")
        AF.request(url)
            .validate(statusCode: 200..<300)
            .responseData { res in
                completion(res.result)
            }
    }
    
    private func request(route: String, completion: @escaping HPResult<[HpCharacter]>){
        AF.request("\(_baseUrl)/\(route)")
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: [HpCharacter].self) { response in
                completion(response.result)
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
