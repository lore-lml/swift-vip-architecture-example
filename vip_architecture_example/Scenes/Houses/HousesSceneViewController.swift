//
//  HousesSceneViewController.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 29/06/22.
//  Copyright (c) 2022 Lorenzo Limoli. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates
//  https://github.com/lore-lml

import UIKit


class HousesSceneViewController: UIViewController {
    
    var router: IHousesSceneRouter!
    
    // MARK: OUTLETS
    @IBOutlet var houseCards: [CardView]!
    
    private let _houses: [HPHouse] = [.gryffindor, .slytherin, .hufflepuff, .ravenclaw]
    private var _tapRecognizers: [UITapGestureRecognizer] = []
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NavBarCustomizer.defaultStyle(for: self)
        
        houseCards.forEach{
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(_didSelectHouse(sender:)))
            _tapRecognizers.append(tapRecognizer)
            $0.addGestureRecognizer(tapRecognizer)
        }
        
    }
    
    @objc private func _didSelectHouse(sender: UITapGestureRecognizer){
        let index = _tapRecognizers.firstIndex(of: sender)!
        router.showCharactersOf(house: _houses[index])
    }
    
}