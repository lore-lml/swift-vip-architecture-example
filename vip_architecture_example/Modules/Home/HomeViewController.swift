//
//  HomeViewController.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 22/06/22.
//

import UIKit

// MARK: Controller Delegate
protocol IHomeDelegate: AnyObject{
    func fetchInputViewModel(vm: FetchInput.ViewModel)
}

class HomeViewController: UIViewController {
    
    var router: IHomeRouter!
    var interactor: IHomeInteractor!

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        interactor.fetchInputRequest()
    }


    @IBAction func didTapButton(_ sender: Any) {
        router.goToDetail(input: DetailSceneInput(input: "My Custom Detail"))
    }
}


extension HomeViewController: IHomeDelegate{
    func fetchInputViewModel(vm: FetchInput.ViewModel){
        label.text = vm.title
    }
}
