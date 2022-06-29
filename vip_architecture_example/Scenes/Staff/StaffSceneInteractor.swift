//
//  StaffSceneInteractor.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 29/06/22.
//  Copyright (c) 2022 Lorenzo Limoli. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates
//  https://github.com/lore-lml

import Foundation

// MARK: Interactor Requests interface
protocol IStaffSceneInteractor: AnyObject{
    func fetchStaffRequest()
    func fetchStaffImageRequest(_ request: StaffSceneModels.FetchStaffImage.Request)
    func showCharacterDetailRequest(_ request: StaffSceneModels.ShowCharacterDetail.Request)
}

class StaffSceneInteractor {
    
    var presenter: IStaffScenePresenter
    private let _staffWorker: HpStaffWorker
    private let _staffImagesWorker: HpStaffImagesWorker
    
    init(presenter: IStaffScenePresenter, hpService: HPService){
        self.presenter = presenter
        self._staffWorker = .init(hpService: hpService)
        self._staffImagesWorker = .init(hpService: hpService)
    }

}

extension StaffSceneInteractor: IStaffSceneInteractor{
    // MARK: BUSINESS LOGIC INTERFACE IMPLEMENTATIONS
    func fetchStaffRequest(){
        _staffWorker.getStaff { [weak self] res in
            switch res{
            case .success(let students):
                self?.presenter.fetchStaffResponse(students)
            case .failure(let err):
                self?.presenter.showErrorResponse(.init(error: err))
            }
        }
    }
    
    func fetchStaffImageRequest(_ request: StaffSceneModels.FetchStaffImage.Request){
        let selectedCharacter = request.dtoCharacter
        _staffImagesWorker.getStaffImage(character: selectedCharacter) { [weak self] res in
            
            let img: Data?
            
            switch res{
            case .success(let imgData):
                img = imgData
                
            case .failure:
                img = nil
            }
            
            let response = StudentsSceneModels.FetchStudentImage.Response(
                cellIndex: request.cellIndex,
                studentImg: img
            )
            
            self?.presenter.fetchStaffImageResponse(response)
            
        }
    }
    
    func showCharacterDetailRequest(_ request: StaffSceneModels.ShowCharacterDetail.Request){
        let selectedCharacter = request.dtoCharacter
        let detail = _staffWorker.getDetailOf(character: selectedCharacter)
        _staffImagesWorker.getStaffImage(character: selectedCharacter) { [weak self] res in
            let data = try? res.get()
            self?.presenter.showCharacterDetailResponse(
                .init(studentImg: data, detail: detail)
            )
        }
        
        
    }
}