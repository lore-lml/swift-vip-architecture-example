//
//  DetailSceneViewController.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 21/06/22.
//

import UIKit

// MARK: Controller Delegate
protocol IDetailSceneDelegate: AnyObject{
    
}

class DetailSceneViewController: UIViewController {
    
    var router: IDetailSceneRouter!
    var interactor: IDetailSceneInteractor!
    var input: DetailSceneAdapter.Input?
    
    @IBOutlet weak var detailLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailLabel.text = input
    }

}

extension DetailSceneViewController: IDetailSceneDelegate{
    
}
