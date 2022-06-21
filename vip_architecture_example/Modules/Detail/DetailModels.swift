//
//  DetailModel.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 21/06/22.
//

import Foundation

struct DetailFetchInitInput{
    
    struct Request{}
    
    struct Response{
        var input: DetailAdapter.Input
    }
    
    struct ViewModel{
        var title: String
    }
    
}
