//
//  CharacterTableViewCell.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 23/06/22.
//

import UIKit
import SDWebImage

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
    
    
    func configure(character: CharacterList.FetchCharacters.ViewModel.CharacterVm){
        nameLabel.text = character.name
        houseLabel.text = character.house
        
        imgView.isHidden = true
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        imgView.sd_setImage(
            with: URL(string: character.image),
            placeholderImage: Self.placeholder) { [weak self] _, _, _, _ in
                
                self?.activityIndicator.stopAnimating()
                self?.activityIndicator.isHidden = true
                self?.imgView.isHidden = false

        }
        
        selectedBackgroundView = Self.bgView
    }
    
}
