//
//  CharacterTableViewCell.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 23/06/22.
//

import UIKit

class CharacterTableViewCell: UITableViewCell, XibSubscribable {
    
    static var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundSelectionCell
        return view
    }()

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    func configure(character: CharacterListSceneModels.FetchCharacters.ViewModel){
        nameLabel.text = character.name
        houseLabel.text = character.house
        imgView.image = character.image
        
        if character.isLoading{
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        }else{
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
        
        selectedBackgroundView = Self.bgView
    }
    
}
