//
//  Extension+HPHouse.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 27/06/22.
//

import Foundation
import UIKit

fileprivate let gryffindorImg: UIImage = .init(named: "gryffindor")!
fileprivate let slytherinImg: UIImage = .init(named: "slytherin")!
fileprivate let huffleouffImg: UIImage = .init(named: "hufflepuff")!
fileprivate let ravenclawImg: UIImage = .init(named: "ravenclaw")!

extension HpHouse{
    var img: UIImage?{
        switch self {
        case .gryffindor: return gryffindorImg
        case .slytherin: return slytherinImg
        case .hufflepuff: return huffleouffImg
        case .ravenclaw: return ravenclawImg
        case .none: return nil
        }
    }
    
    var color: UIColor{
        switch self {
        case .gryffindor: return .gryffindor
        case .slytherin: return .slytherin
        case .hufflepuff: return .hufflepuff
        case .ravenclaw: return .ravenclaw
        case .none: return .noneHouseColor
        }
    }
}
