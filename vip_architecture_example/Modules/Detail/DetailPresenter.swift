//
//  DetailPresenter.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 21/06/22.
//

import Foundation

// MARK: Response to ViewModel methods mappers
protocol IDetailPresenter{
    
    func fetchStartingInputResponse(_ response: DetailFetchInitInput.Response)
}

class DetailPresenter: IDetailPresenter{
    weak var view: IDetailDelegate?
    
    init(view: IDetailDelegate){
        self.view = view
    }
    
    func fetchStartingInputResponse(_ response: DetailFetchInitInput.Response){
        view?.fetchStartingInputViewModel(.init(title: response.input))
    }
}
