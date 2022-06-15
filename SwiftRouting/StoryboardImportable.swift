//
//  StoryboardImportable.swift
//  SwiftRouting
//
//  Created by Lorenzo Limoli on 15/06/22.
//

import UIKit

public protocol StoryboardImportable: UIViewController{
    static var storyboardId: String {get}
    static var storyboardBundle: Bundle {get}
    static var storyboardName: String {get}
    static func instantiate() -> Self
}

public extension StoryboardImportable{
    static var storyboardName: String {
        "Main"
    }
    
    static var storyboardId: String{
        String(describing: self)
    }
    
    static var storyboardBundle: Bundle {
        Bundle(for: Self.self)
    }
    
    static func instantiate() -> Self{
        let storyboard = UIStoryboard(name: storyboardName, bundle: storyboardBundle)
        
        guard let controller = storyboard.instantiateViewController(withIdentifier: storyboardId) as? Self else{
            fatalError("Unable to instantiate controller with identifier \(storyboardId)")
        }
        
        return controller;
    }
}
