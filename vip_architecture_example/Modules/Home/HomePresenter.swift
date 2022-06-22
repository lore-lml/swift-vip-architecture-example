//
//  HomePresenter.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 21/06/22.
//

import Foundation

// MARK: Response to ViewModel methods mappers
protocol IHomePresenter{
    func fetchInputResponse(input: FetchInput.Response)
}

class HomePresenter: IHomePresenter{
    weak var view: IHomeDelegate?
    
    init(view: IHomeDelegate){
        self.view = view
    }

    func fetchInputResponse(input: FetchInput.Response){
        view?.fetchInputViewModel(vm: .init(title: input.input))
    }
}
