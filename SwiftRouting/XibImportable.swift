//
//  XibImportable.swift
//  SwiftRouting
//
//  Created by Lorenzo Limoli on 15/06/22.
//

import UIKit

public protocol XibImportable: UIViewController{
    static func loadFromXib() -> Self
}

public extension XibImportable{
    static func loadFromXib() -> Self {
        
        let nibName = String(describing: type(of: Self.self))
        
        let bundle = Bundle(for: Self.self)
    
        let controller = Self(nibName: nibName, bundle: bundle)
        
        return controller
    }
}
