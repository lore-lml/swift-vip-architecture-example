//
//  HomeViewController.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 22/06/22.
//

import UIKit

// MARK: Controller Delegate
protocol IHomeSceneDelegate: AnyObject{
    
}

class HomeSceneViewController: UIViewController {
    
    var router: IHomeSceneRouter!
    var interactor: IHomeSceneInteractor!
    var input: HomeSceneAdapter.Input?

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = input
    }


    @IBAction func didTapButton(_ sender: Any) {
        router.goToDetail(input: HomeSceneModels.DetailSceneInput(input: "My Custom Detail"))
    }
}


extension HomeSceneViewController: IHomeSceneDelegate{

}
