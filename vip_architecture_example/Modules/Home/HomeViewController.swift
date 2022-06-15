//
//  HomeViewController.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 15/06/22.
//

import UIKit
import SwiftRouting

class HomeViewController: UIViewController, RoutedController {
    
    typealias PresentationInput = String
    
    var presentationInput: String?

    @IBOutlet weak var homeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let presentationInput = presentationInput {
            homeLabel.text = presentationInput
        }
    }
    
    @IBAction func didTapGoToDetail(_ sender: Any) {
        
        AppRouter.instance.go(from: self, to: DetailViewController.self)
        
    }
}
