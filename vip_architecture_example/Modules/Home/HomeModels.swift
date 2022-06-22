//
//  HomeModel.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 22/06/22.
//

import Foundation

struct DetailSceneInput{
    let input: String
}

struct FetchInput{
    
    struct Request{}
    
    struct Response{
        var input: HomeAdapter.Input
    }
    
    struct ViewModel{
        var title: String
    }
    
}
