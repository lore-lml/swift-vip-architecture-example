//
//  DetailViewController.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 21/06/22.
//

import UIKit

// MARK: Controller Delegate
protocol IDetailDelegate: AnyObject{
    
    func fetchStartingInputViewModel(_ viewModel: DetailFetchInitInput.ViewModel)
}

class DetailViewController: UIViewController {
    
    var router: IDetailRouter!
    var interactor: IDetailInteractor!
    
    @IBOutlet weak var detailLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor.fetchStartingInputRequest()
    }

}

extension DetailViewController: IDetailDelegate{
    func fetchStartingInputViewModel(_ viewModel: DetailFetchInitInput.ViewModel){
        detailLabel.text = viewModel.title
    }
}
