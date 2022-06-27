//
//  XibImportable.swift
//  SwiftRouting
//
//  Created by Lorenzo Limoli on 27/06/22.
//

import UIKit

public protocol XibImportable: UIViewController{
    static var xibname: String { get }
    static var xibBundle: Bundle { get }
    static func fromXib() -> Self
}

public extension XibImportable{
    
    static var xibname: String { String(describing: self) }
    static var xibBundle: Bundle { .init(for: Self.self) }
    
    static func fromXib() -> Self{
        .init(nibName: xibname, bundle: xibBundle)
    }
}
