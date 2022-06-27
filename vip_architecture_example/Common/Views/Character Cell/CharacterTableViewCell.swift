//
//  CharacterTableViewCell.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 23/06/22.
//

import UIKit

class CharacterTableViewCell: UITableViewCell, XibSubscribable {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    func configure(character: StudentsSceneModels.FetchStudents.ViewModel){
        nameLabel.text = character.name
        houseLabel.text = character.house
        imgView.image = character.image
        activityIndicator.isHidden = !character.isLoading
    }
    
}
