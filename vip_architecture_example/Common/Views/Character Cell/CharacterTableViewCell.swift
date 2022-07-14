//
//  CharacterTableViewCell.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 23/06/22.
//

import UIKit

class CharacterTableViewCell: UITableViewCell, XibSubscribable {
    private static let placeholder = UIImage(named: "placeholder")!
    
    static var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundSelectionCell
        return view
    }()

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var houseLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    func configure(character: CharacterList.FetchCharacters.ViewModel){
        nameLabel.text = character.name
        houseLabel.text = character.house
        imgView.image = character.imageData == nil ? Self.placeholder : character.imageData?.image
        
        imgView.isHidden = character.isLoading
        activityIndicator.isHidden = !character.isLoading
        
        if character.isLoading{
            activityIndicator.startAnimating()
        }else{
            activityIndicator.stopAnimating()
        }
        
        selectedBackgroundView = Self.bgView
    }
    
}
