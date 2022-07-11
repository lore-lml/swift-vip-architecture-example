//
//  CharacterListSceneInteractor.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 29/06/22.
//  Copyright (c) 2022 Lorenzo Limoli. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates
//  https://github.com/lore-lml

import Foundation

// MARK: Interactor Requests interface
protocol ICharacterListSceneInteractor: AnyObject{
    func fetchCharactersRequest(_ request: CharacterList.FetchCharacters.Request)
    
    func fetchCharacterImageRequest(_ request: CharacterList.FetchCharacterImage.Request)
    
    func showCharacterDetailRequest(_ request: CharacterList.ShowCharacterDetail.Request)
}

class CharacterListSceneInteractor {
    
    var presenter: ICharacterListScenePresenter
    private let _characterWorker: HpCharacterWorker
    private let _characterImageWorker: HpCharacterImageWorker
    
    init(presenter: ICharacterListScenePresenter, hpService: HPService){
        self.presenter = presenter
        self._characterWorker = .init(hpService: hpService)
        self._characterImageWorker = .init(hpService: hpService)
    }

}

extension CharacterListSceneInteractor: ICharacterListSceneInteractor{
    // MARK: BUSINESS LOGIC INTERFACE IMPLEMENTATIONS
    
    func fetchCharactersRequest(_ request: CharacterList.FetchCharacters.Request){
        
        let completion: HPResult<[DtoHpCharacter]> = { [weak self] res in
            
            switch res{
            case .success(let characters):
                self?.presenter.fetchCharactersResponse(.init(characters: characters))
            case .failure(let err):
                self?.presenter.showErrorResponse(.init(error: err))
            }
            
        }
        
        switch request.listType{
        case .house(let house):
            _characterWorker.getHouseCharacters(house: house, completion: completion)
        case .staff:
            _characterWorker.getStaff(completion: completion)
        case .students:
            _characterWorker.getStudents(completion: completion)
        }
        
    }
    
    func fetchCharacterImageRequest(_ request: CharacterList.FetchCharacterImage.Request){
        
        let selectedCharacter = request.dtoCharacter
        
        _characterImageWorker.getImageOf(character: selectedCharacter) { [weak self] res in
            
            let img: Data?
            
            switch res{
            case .success(let imgData):
                img = imgData
                
            case .failure:
                img = nil
            }
            
            let response = CharacterList.FetchCharacterImage.Response(
                cellIndex: request.cellIndex,
                characterImg: img
            )
            
            self?.presenter.fetchCharacterImageResponse(response)
            
        }
        
    }
    
    
    func showCharacterDetailRequest(_ request: CharacterList.ShowCharacterDetail.Request){
        
        let selectedCharacter = request.dtoCharacter
        
        let detail = _characterWorker.getDetailOf(character: selectedCharacter)
        
        _characterImageWorker.getImageOf(character: selectedCharacter) { [weak self] res in
            let data = try? res.get()
            self?.presenter.showCharacterDetailResponse(
                .init(studentImg: data, detail: detail)
            )
        }
        
    }
}
