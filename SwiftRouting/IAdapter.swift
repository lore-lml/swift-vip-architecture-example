//
//  IAdapter.swift
//  SwiftRouting
//
//  Created by Lorenzo Limoli on 22/06/22.
//

import UIKit
import Swinject

public protocol IAdapter: AnyObject{
    
    associatedtype Input: Any
    
    static func setup(input: Input?, assembler: Assembler?) -> UIViewController
}
