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
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05)
        return view
    }()

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    func configure(character: StudentsSceneModels.FetchStudents.ViewModel){
        nameLabel.text = character.name
        houseLabel.text = character.house
        imgView.image = character.image
        activityIndicator.isHidden = !character.isLoading
        
        
        selectedBackgroundView = Self.bgView
    }
    
}
