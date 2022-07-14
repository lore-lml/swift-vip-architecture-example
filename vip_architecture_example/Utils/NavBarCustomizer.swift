//
//  NavBarCustomizer.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 27/06/22.
//

import UIKit

public final class NavBarCustomizer{
    
    let navBar: UINavigationBar?
    let navItem: UINavigationItem?
    
    public init(navBar: UINavigationBar? = nil, navItem: UINavigationItem? = nil){
        self.navBar = navBar
        self.navItem = navItem
    }
    
    @discardableResult
    public func centeredImage(_ image: UIImage?) -> Self{
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        navItem?.titleView = imageView
        return self
    }
    
    @discardableResult
    public func barTint(_ color: UIColor) -> Self{
        navBar?.barTintColor = color
        return self
    }
    
    @discardableResult
    public func buttonsTint(_ color: UIColor) -> Self{
        navBar?.tintColor = color
        return self
    }
    
    @discardableResult
    public func addRightButton(_ button: UIBarButtonItem) -> Self{
        guard let navItem = navItem else {
            return self
        }
        
        if navItem.rightBarButtonItems == nil{
            navItem.rightBarButtonItems = []
        }
        
        navItem.rightBarButtonItems! += [button]
        
        return self
    }
    
    @discardableResult
    public func addLeftButton(_ button: UIBarButtonItem) -> Self{
        guard let navItem = navItem else {
            return self
        }
        
        if navItem.leftBarButtonItems == nil{
            navItem.leftBarButtonItems = []
        }
        
        navItem.leftBarButtonItems! += [button]
        
        return self
    }
    
    @discardableResult
    public func clearBottomLine() -> Self{
        navBar?.shadowImage = UIImage()
        return self
    }
    
    @discardableResult
    public func backButtonImage(_ image: UIImage) -> Self{
        navBar?.backIndicatorImage = image
        navBar?.backIndicatorTransitionMaskImage = image
        return self
    }
    
    @discardableResult
    public func clearRightButtons() -> Self{
        navItem?.rightBarButtonItems = nil
        return self
    }
    
    @discardableResult
    public func clearLeftButtons() -> Self{
        navItem?.leftBarButtonItems = nil
        return self
    }
    
    @discardableResult
    public func setRightButtons(_ buttons: [UIBarButtonItem]?) -> Self{
        navItem?.rightBarButtonItems = buttons
        return self
    }
    
    @discardableResult
    public func setLeftButtons(_ buttons: [UIBarButtonItem]?) -> Self{
        navItem?.leftBarButtonItems = buttons
        return self
    }
    
    @discardableResult
    public func backButtonTitle(_ title: String) -> Self{
        let backItem = UIBarButtonItem()
        backItem.title = title
        navItem?.backBarButtonItem = backItem
        return self
    }
    
    @discardableResult
    public func hideBackButton() -> Self{
        navItem?.hidesBackButton = true
        return self
    }
    
}

fileprivate var logo = UIImage(named: "hp-logo")!

extension NavBarCustomizer{
    
    static func defaultStyle(
        for viewController: UIViewController,
        rightBarButton: UIBarButtonItem? = nil,
        leftBarButton: UIBarButtonItem? = nil,
        image: UIImage = logo,
        hideBackButton: Bool = false){
        
        let customizer = NavBarCustomizer(navBar: viewController.navigationController?.navigationBar, navItem: viewController.navigationItem)
            .centeredImage(image)
            .backButtonTitle("")
        
        if hideBackButton{
            customizer.hideBackButton()
        }

        if let rightBarButton = rightBarButton {
            customizer.setRightButtons([rightBarButton])
        }else{
            customizer.setRightButtons([])
        }
        
        if let leftBarButton = leftBarButton {
            customizer.setLeftButtons([leftBarButton])
        }else{
            customizer.setLeftButtons([])
        }
    }
}
