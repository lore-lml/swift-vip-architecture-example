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
    
    func getAllCharacters(completion: @escaping HPResult<[HPCharacter]>){
        request(route: "", completion: completion)
    }
    
    func getStudents(completion: @escaping HPResult<[HPCharacter]>){
        request(route: "students", completion: completion)
    }
    
    func getStaff(completion: @escaping HPResult<[HPCharacter]>){
        request(route: "staff", completion: completion)
    }
    
    func getCharactersOf(house: HPHouse, completion: @escaping HPResult<[HPCharacter]>){
        request(route: "house/\(house.rawValue)", completion: completion)
    }
    
    private func request(route: String, completion: @escaping HPResult<[HPCharacter]>){
        AF.request("\(_baseUrl)/\(route)")
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseDecodable(of: [HPCharacter].self) { response in
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
