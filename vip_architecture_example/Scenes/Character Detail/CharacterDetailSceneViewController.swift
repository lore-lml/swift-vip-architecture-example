//
//  CharacterDetailSceneViewController.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 27/06/22.
//  Copyright (c) 2022 Lorenzo Limoli. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates
//  https://github.com/lore-lml

import UIKit
import SDWebImage

// MARK: Controller Delegate
protocol ICharacterDetailSceneDelegate: AnyObject{
    
}

class CharacterDetailSceneViewController: UIViewController  {
    
    private static let placeholder = UIImage(named: "placeholder")!
    
    var router: ICharacterDetailSceneRouter!
    var interactor: ICharacterDetailSceneInteractor!
    var input: CharacterDetail.Input?
    
    // MARK: OUTLETS
    @IBOutlet weak var topBackgroundView: UIView!
    @IBOutlet weak var characterImgView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var houseContainer: UIStackView!
    @IBOutlet weak var houseImgView: UIImageView!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var birtDateContainer: UIStackView!
    @IBOutlet weak var birthDateLabel: UILabel!
    @IBOutlet weak var aliveLabel: UILabel!
    @IBOutlet weak var wandContainer: UIStackView!
    @IBOutlet weak var wandLabel: UILabel!
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !isModal{
            NavBarCustomizer.defaultStyle(for: self)
        }else{
            let btnItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(_didTapClose))
            NavBarCustomizer.defaultStyle(for: self, leftBarButton: btnItem, hideBackButton: true)
        }
        
        
        _setupView()
    }
    
    private func _setupView(){

        topBackgroundView.backgroundColor = input?.houseColor
        
        characterImgView.sd_setImage(
            with: URL(string: input?.characterImage ?? ""),
            placeholderImage: Self.placeholder
        )
        
        characterNameLabel.text = input?.characterName
        
        houseContainer.isHidden = input?.houseImg == nil
        houseImgView.image = input?.houseImg
        
        genderLabel.text = input?.gender
        
        speciesLabel.text = input?.species
        
        birtDateContainer.isHidden = input?.dateOfBirth.isEmpty ?? true
        birthDateLabel.text = input?.dateOfBirth
        
        aliveLabel.text = input?.alive
        
        wandContainer.isHidden = input?.wand.isEmpty ?? true
        wandLabel.text = input?.wand
    }
    
    @objc private func _didTapClose(){
        self.router.backToCharactersList()
    }
}

extension CharacterDetailSceneViewController: ICharacterDetailSceneDelegate{
    // MARK: DISPLAY LOGIC IMPLEMENTATION INTERFACE
}
