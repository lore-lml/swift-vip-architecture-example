//
//  XibSubscribable.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 27/06/22.
//

import Foundation
import UIKit


public protocol XibSubscribable{
    static var nibId: String { get }
    static var cellId: String { get }
    
    static func getNib() -> UINib?
}

public extension XibSubscribable{
    static var nibId: String {
        String(describing: self)
    }
    
    static var cellId: String {
        return nibId
    }
    
    static func getNib() -> UINib?{
        return UINib(nibName: nibId, bundle: .main)
    }
}

public extension XibSubscribable where Self: UITableViewCell{
    
    static func subscribe(to tableView: UITableView){
        tableView.register(getNib(), forCellReuseIdentifier: cellId)
    }
}

public extension XibSubscribable where Self: UICollectionViewCell{
    
    static func subscribe(to collectionView: UICollectionView){
        collectionView.register(getNib(), forCellWithReuseIdentifier: cellId)
    }
}

public extension XibSubscribable where Self: UIView{
    
    static func loadView() -> Self?{
        let bundle = Bundle(for: Self.self)
        let nib = UINib(nibName: nibId, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? Self
    }
}

